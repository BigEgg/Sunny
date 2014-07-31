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

int const firstSkipSeconds = 7;
int const lastSkipSeconds = 10;

#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInit = NO;

        accelerometerDataPackage = [[DataPackage alloc] init];
        accelerometerDataPackage.phoneData = [[PhoneData alloc] init];
        accelerometerDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        accelerometerDataPackage.phoneData.phoneStats = Stop;

        gyroscopeDataPackage = [[DataPackage alloc] init];
        gyroscopeDataPackage.phoneData = [[PhoneData alloc] init];
        gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        gyroscopeDataPackage.phoneData.phoneStats = Stop;

        self.isSentRecord = NO;
        self.isStartRecord = NO;
    }
    return self;
}

- (id)initWithNibNameAndFile:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fileName:(NSString *)fileName {
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInit = YES;

//        accelerometerDataPackage = accelerometerData;
//        gyroscopeDataPackage = gyroscopeData;

        recordFileName = fileName;

        isInit = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (!recordFileName) {
        self.title = @"New Record";
    } else {
        self.title = recordFileName;
    }

    [self setUIControls];
    [self.sectionView addSubview:self.recordInfoView];

    self.noticeLable.text = [[NSString alloc] initWithFormat:@"%@ %d %@ %d %@",
                                                             @"Notice: The records will skip first",
                                                             firstSkipSeconds,
                                                             @"seconds and last",
                                                             lastSkipSeconds,
                                                             @"seconds data."];
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

    accelerometerDataPackage.phoneData.phoneStats = phoneStatus;
    gyroscopeDataPackage.phoneData.phoneStats = phoneStatus;
}

- (IBAction)stopRecord:(id)sender {
    self.isStartRecord = NO;

    if ([accelerometerDataPackage.data count] >
            (int) ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds + (int) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds) {
        accelerometerDataPackage.data = (NSMutableArray <ISensorData> *)
                [accelerometerDataPackage.data subarrayWithRange:NSMakeRange(
                        (NSUInteger) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds,
                        [accelerometerDataPackage.data count] - (int) ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds - (int) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds)];
    } else {
        [accelerometerDataPackage.data removeAllObjects];
    }

    if ([gyroscopeDataPackage.data count] >
            (int) GYROSCOPE_UPDATE_TIMES * firstSkipSeconds + (int) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds) {
        gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *)
                [gyroscopeDataPackage.data subarrayWithRange:NSMakeRange(
                        (NSUInteger) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds,
                        [gyroscopeDataPackage.data count] - (int) GYROSCOPE_UPDATE_TIMES * firstSkipSeconds - (int) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds)];
    } else {
        [accelerometerDataPackage.data removeAllObjects];
    }

    [self setUIControls];
}

- (IBAction)startRecord:(id)sender {
    self.isStartRecord = YES;

    [self setUIControls];
}

- (IBAction)cancelRecord:(id)sender {
    self.isStartRecord = NO;
    [accelerometerDataPackage.data removeAllObjects];
    [gyroscopeDataPackage.data removeAllObjects];

    [self setUIControls];
}

- (IBAction)sendRecord:(id)sender {
    self.isSentRecord = YES;

    [self setUIControls];
}

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.recordInfoView];
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Section View Segement is invalid, index: %d",
                               sectionControl.selectedSegmentIndex];
    }
}

#pragma mark - Sensor Data Handlers

- (void)accelerometerHandler:(AccelerometerData *)data {
    [accelerometerDataPackage.data addObject:data];

    self.recordSecondsLable.text = [self getRecordTime:++recordCount];
}


- (void)gyroscopeHandler:(GyroscopeData *)data {
    [gyroscopeDataPackage.data addObject:data];
}

#pragma mark - Private Methods

- (void)setUIControls {
    [self setButtonsStats];
    [self setSegmentStats];
}


- (void)setButtonsStats {
    bool haveData = [accelerometerDataPackage.data count] > 0;

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
    bool haveData = [accelerometerDataPackage.data count] > 0;

    self.phoneMovingSegment.enabled = NO;
    self.phonePositionSegment.enabled = NO;
    self.phoneSideSegment.enabled = NO;

    if (!haveData && !self.isStartRecord) {
        self.phoneMovingSegment.enabled = YES;
        self.phonePositionSegment.enabled = YES;
        self.phoneSideSegment.enabled = YES;
        return;
    } else {
        PhoneStatus phoneStatus = accelerometerDataPackage.phoneData.phoneStats;
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

- (NSString *)getRecordTime:(int)accelerometerCount {
    int seconds = (int) (accelerometerCount / ACCELEROMETER_UPDATE_TIMES);

    int h = seconds / 3600;
    int m = (seconds / 60) % 60;
    int s = seconds % 60;

    return [NSString stringWithFormat:@"%d:%02d:%02d", h, m, s];
}

@end
