//
//  RecordDetailViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordDetailViewController.h"
#import "MotionService.h"

@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController

@synthesize accelerometerDataPackage, gyroscopeDataPackage;

int const firstSkipSeconds = 10;
int const lastSkipSeconds = 10;

#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInit = NO;
        
        self.accelerometerDataPackage = [[DataPackage alloc] init];
        self.accelerometerDataPackage.phoneData = [[PhoneData alloc] init];
        self.accelerometerDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        self.accelerometerDataPackage.phoneData.phoneStats = Stop;

        self.gyroscopeDataPackage = [[DataPackage alloc] init];
        self.gyroscopeDataPackage.phoneData = [[PhoneData alloc] init];
        self.gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        self.gyroscopeDataPackage.phoneData.phoneStats = Stop;

        self.isSentRecord = NO;
        self.isStartRecord = NO;
    }
    return self;
}

- (id)iniWithNibNameAndData:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil accelerometerDataPackage:(DataPackage *)accelerometerData gyroscopeDataPackage:(DataPackage *)gyroscopeData {
    [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInit = YES;
        
        self.accelerometerDataPackage = accelerometerData;
        self.gyroscopeDataPackage = gyroscopeData;

        isInit = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (!self.fileName) {
        self.title = @"New Record";
    } else {
        self.title = self.fileName;
    }

    [self SetUIControls];
    [self.sectionView addSubview:self.recordInfoView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)phoneStatusChanged:(id)sender {
    if (isInit) {
        return;
    }
    
    PhoneStatus phoneStatus;
    switch (self.phoneMovingSegment.selectedSegmentIndex) {
        case 0:
            phoneStatus = Stop;
            break;
        case 1:
            phoneStatus = Shake;
            break;
        case 2:
            phoneStatus = Run;
            break;
        case 3:
            phoneStatus = Walk;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Moving Segment is invalid, index: %d",
                               self.phoneMovingSegment.selectedSegmentIndex];
    }

    switch (self.phoneSideSegment.selectedSegmentIndex) {
        case 0:
            phoneStatus = phoneStatus | Left;
            break;
        case 1:
            phoneStatus = phoneStatus | Right;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Side Segment is invalid, index: %d",
                               self.phoneSideSegment.selectedSegmentIndex];
    }

    switch (self.phonePositionSegment.selectedSegmentIndex) {
        case 0:
            phoneStatus = phoneStatus | Handheld;
            break;
        case 1:
            phoneStatus = phoneStatus | Using;
            break;
        case 2:
            phoneStatus = phoneStatus | Pocket;
            break;
        case 3:
            phoneStatus = phoneStatus | Handbag;
            break;
        case 4:
            phoneStatus = phoneStatus | TrousersFrontPocket;
            break;
        case 5:
            phoneStatus = phoneStatus | TrousersBackPocket;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Position Segment is invalid, index: %d",
                               self.phonePositionSegment.selectedSegmentIndex];

    }

    self.accelerometerDataPackage.phoneData.phoneStats = phoneStatus;
    self.gyroscopeDataPackage.phoneData.phoneStats = phoneStatus;
}

- (IBAction)stopRecord:(id)sender {
    self.isStartRecord = NO;
    
    if ([self.accelerometerDataPackage.data count] >
            (int)ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds + (int)ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds) {
        self.accelerometerDataPackage.data = (NSMutableArray <ISensorData> *)
                [self.accelerometerDataPackage.data subarrayWithRange:NSMakeRange(
                                        (NSUInteger) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds,
                                        [self.accelerometerDataPackage.data count] - (int) ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds - (int) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds)];
    } else {
        [self.accelerometerDataPackage.data removeAllObjects];
    }

    if ([self.gyroscopeDataPackage.data count] >
            (int)GYROSCOPE_UPDATE_TIMES * firstSkipSeconds + (int)GYROSCOPE_UPDATE_TIMES * lastSkipSeconds) {
        self.gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *)
                [self.gyroscopeDataPackage.data subarrayWithRange:NSMakeRange(
                        (NSUInteger) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds,
                        [self.gyroscopeDataPackage.data count] - (int) GYROSCOPE_UPDATE_TIMES * firstSkipSeconds - (int) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds)];
    } else {
        [self.accelerometerDataPackage.data removeAllObjects];
    }
    
    [self SetUIControls];
}

- (IBAction)startRecord:(id)sender {
    self.isStartRecord = YES;

    [self SetUIControls];
}

- (IBAction)cancelRecord:(id)sender {
    self.isStartRecord = NO;
    [self.accelerometerDataPackage.data removeAllObjects];
    [self.gyroscopeDataPackage.data removeAllObjects];

    [self SetUIControls];
}

- (IBAction)sendRecord:(id)sender {
    self.isSentRecord = YES;

    [self SetUIControls];
}

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.recordInfoView];
            break;
        default:
            break;
    }
}

#pragma mark - Private Methods

- (void)SetUIControls {
    [self setButtonsStats];
    [self setSegmentStats];
}


- (void)setButtonsStats {
    bool haveData = [self.accelerometerDataPackage.data count] > 0;

    self.startButton.enabled = NO;
    self.stopButton.enabled = NO;
    self.cancelButton.enabled = NO;
    self.sendButton.enabled = NO;

    if (!haveData && !self.isStartRecord) {
        self.startButton.enabled = YES;
        return;
    }

    if (self.isStartRecord) {
        self.stopButton.enabled = YES;
        self.cancelButton.enabled = YES;
        return;
    }

    if (haveData && !self.isStartRecord && !self.isSentRecord) {
        self.sendButton.enabled = YES;
        return;
    } else {
        self.sendButton.enabled = NO;
        self.sendButton.titleLabel.text = @"Sent";
    }
}

- (void)setSegmentStats {
    bool haveData = [self.accelerometerDataPackage.data count] > 0;

    self.phoneMovingSegment.enabled = NO;
    self.phonePositionSegment.enabled = NO;
    self.phoneSideSegment.enabled = NO;

    if (!haveData && !self.isStartRecord) {
        self.phoneMovingSegment.enabled = YES;
        self.phonePositionSegment.enabled = YES;
        self.phoneSideSegment.enabled = YES;
        return;
    } else {
        PhoneStatus phoneStatus = self.accelerometerDataPackage.phoneData.phoneStats;
        NSInteger selectIndex = 0;

        if (phoneStatus & Stop) {
            selectIndex = 0;
        } else if (phoneStatus & Shake) {
            selectIndex = 1;
        } else if (phoneStatus & Run) {
            selectIndex = 2;
        } else if (phoneStatus & Walk) {
            selectIndex = 3;
        }
        self.phoneMovingSegment.selectedSegmentIndex = selectIndex;

        selectIndex = 0;
        if (phoneStatus & Left) {
            selectIndex = 0;
        } else if (phoneStatus & Right) {
            selectIndex = 1;
        }
        self.phoneSideSegment.selectedSegmentIndex = selectIndex;

        selectIndex = 0;
        if (phoneStatus & Handheld) {
            selectIndex = 0;
        } else if (phoneStatus & Using) {
            selectIndex = 1;
        } else if (phoneStatus & Pocket) {
            selectIndex = 2;
        } else if (phoneStatus & Handbag) {
            selectIndex = 3;
        } else if (phoneStatus & TrousersFrontPocket) {
            selectIndex = 4;
        } else if (phoneStatus & TrousersBackPocket) {
            selectIndex = 5;
        }
        self.phonePositionSegment.selectedSegmentIndex = selectIndex;
    }
}

#pragma mark - Sensor Data Handlers

- (void)accelerometerHandler:(AccelerometerData *)data {
    [self.accelerometerDataPackage.data addObject:data];
}


- (void)gyroscopeHandler:(GyroscopeData *)data {
    [self.gyroscopeDataPackage.data addObject:data];
}

@end
