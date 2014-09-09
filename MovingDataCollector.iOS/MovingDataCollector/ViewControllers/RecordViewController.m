//
//  RecordDetailViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordViewController.h"
#import "MotionService.h"
#import "Utils.h"
#import "COSDrawView.h"
#import "Constants.h"

@interface RecordViewController ()

@end

#define RECORD_DRAW_VIEW_WIDTH 264
#define RECORD_DRAW_VIEW_HEIGHT 136

@implementation RecordViewController

int const firstSkipSeconds = 10;
int const lastSkipSeconds = 10;
PhoneType const phoneType = iPhone4;

#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isInit = NO;
        
        accelerometerDataPackage = [[DataPackage alloc] init];
        accelerometerDataPackage.phoneData = [[PhoneData alloc] init];
        accelerometerDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        accelerometerDataPackage.phoneData.phoneState = Stop;
        accelerometerDataPackage.phoneData.phoneType = phoneType;
        accelerometerDataPackage.phoneData.updateInterval = ACCELEROMETER_UPDATE_TIMES;
        
        gyroscopeDataPackage = [[DataPackage alloc] init];
        gyroscopeDataPackage.phoneData = [[PhoneData alloc] init];
        gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        gyroscopeDataPackage.phoneData.phoneState = Stop;
        gyroscopeDataPackage.phoneData.phoneType = phoneType;
        gyroscopeDataPackage.phoneData.updateInterval = GYROSCOPE_UPDATE_TIMES;
        
        isStartRecord = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.


    [self setUIControls];
    [self.sectionView addSubview:self.recordInfoView];

    self.noticeLable.text = [[NSString alloc] initWithFormat:@"%@ %d %@ %d %@",
                                                             @"Notice: The records will skip first",
                                                             firstSkipSeconds,
                                                             @"seconds and last",
                                                             lastSkipSeconds,
                                                             @"seconds data."];
    self.recordSecondsLable.text = [self getRecordTime:recordCount];
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

    self.phonePositionSegment.enabled = YES;
    self.phoneSideSegment.enabled = YES;

    PhoneState phoneState;
    switch (self.phoneMovingSegment.selectedSegmentIndex) {
        case 0:
            phoneState = Stop;
            self.phonePositionSegment.enabled = NO;
            self.phoneSideSegment.enabled = NO;
            break;
        case 1:
            phoneState = Shake;
            break;
        case 2:
            phoneState = Run;
            break;
        case 3:
            phoneState = Walk;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Moving Segment is invalid, index: %ld",
                               (long) self.phoneMovingSegment.selectedSegmentIndex];
    }

    switch (self.phoneSideSegment.selectedSegmentIndex) {
        case 0:
            phoneState = phoneState | Left;
            break;
        case 1:
            phoneState = phoneState | Right;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Side Segment is invalid, index: %ld",
                               (long) self.phoneSideSegment.selectedSegmentIndex];
    }

    switch (self.phonePositionSegment.selectedSegmentIndex) {
        case 0:
            phoneState = phoneState | Handheld;
            break;
        case 1:
            phoneState = phoneState | Using;
            break;
        case 2:
            phoneState = phoneState | Pocket;
            break;
        case 3:
            phoneState = phoneState | Handbag;
            break;
        case 4:
            phoneState = phoneState | TrousersFrontPocket;
            break;
        case 5:
            phoneState = phoneState | TrousersBackPocket;
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Position Segment is invalid, index: %ld",
                               (long) self.phonePositionSegment.selectedSegmentIndex];

    }

    accelerometerDataPackage.phoneData.phoneState = phoneState;
    gyroscopeDataPackage.phoneData.phoneState = phoneState;
}

- (IBAction)stopRecord:(id)sender {
    isStartRecord = NO;

    if ([accelerometerDataPackage.data count] >
            (int) ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds + (int) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds) {
        accelerometerDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] initWithArray:
                [accelerometerDataPackage.data subarrayWithRange:NSMakeRange(
                        (NSUInteger) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds,
                        [accelerometerDataPackage.data count] - (int) ACCELEROMETER_UPDATE_TIMES * firstSkipSeconds - (int) ACCELEROMETER_UPDATE_TIMES * lastSkipSeconds)]];
    } else {
        [accelerometerDataPackage.data removeAllObjects];
    }

    if ([gyroscopeDataPackage.data count] >
            (int) GYROSCOPE_UPDATE_TIMES * firstSkipSeconds + (int) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds) {
        gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] initWithArray:
                [gyroscopeDataPackage.data subarrayWithRange:NSMakeRange(
                        (NSUInteger) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds,
                        [gyroscopeDataPackage.data count] - (int) GYROSCOPE_UPDATE_TIMES * firstSkipSeconds - (int) GYROSCOPE_UPDATE_TIMES * lastSkipSeconds)]];
    } else {
        [accelerometerDataPackage.data removeAllObjects];
    }

    [self setUIControls];
}

- (IBAction)startRecord:(id)sender {
    recordCount = 0;
    self.recordSecondsLable.text = [self getRecordTime:recordCount];

    isStartRecord = YES;

    [self setUIControls];
}

- (IBAction)cancelRecord:(id)sender {
    isStartRecord = NO;
    [accelerometerDataPackage.data removeAllObjects];
    [gyroscopeDataPackage.data removeAllObjects];

    [self setUIControls];
    recordCount = 0;
    self.recordSecondsLable.text = [self getRecordTime:recordCount];
}

- (IBAction)sendRecord:(id)sender {
    NSString *accelerometerUrlPath = [[NSString alloc] initWithFormat:@"%s%s", SUNNY_SERVER, SUNNY_API_ACCELEROMETER];
    NSString *gyroscopeUrlPath = [[NSString alloc] initWithFormat:@"%s%s", SUNNY_SERVER, SUNNY_API_GYROSCOPE];

    [self sendDataPackage:accelerometerDataPackage to:accelerometerUrlPath];
    [self sendDataPackage:gyroscopeDataPackage to:gyroscopeUrlPath];

    [accelerometerDataPackage.data removeAllObjects];
    [gyroscopeDataPackage.data removeAllObjects];

    recordCount = 0;
    self.recordSecondsLable.text = [self getRecordTime:recordCount];
    [self setUIControls];
}

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    
    id<IDrawView> theDrawView = nil;
    
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.recordInfoView];
            break;
        case 1:
            theDrawView = [[COSDrawView alloc] initWithHeight:RECORD_DRAW_VIEW_HEIGHT Width:RECORD_DRAW_VIEW_WIDTH];
            [self.sectionView addSubview:(UIView *)theDrawView];
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Section View Segement is invalid, index: %ld",
                               (long) sectionControl.selectedSegmentIndex];
    }
    
    drawView = theDrawView;
}

#pragma mark - Sensor Data Handlers

- (void)accelerometerHandler:(AccelerometerData *)data {
    if (isStartRecord) {
        [accelerometerDataPackage.data addObject:data];
        self.recordSecondsLable.text = [self getRecordTime:++recordCount];
        
        if (drawView) {
            [drawView drawAccelerometerData:data];
        }
    }
}

- (void)gyroscopeHandler:(GyroscopeData *)data {
    if (isStartRecord) {
        [gyroscopeDataPackage.data addObject:data];
        
        if (drawView) {
            [drawView drawGyroscopeData:data];
        }
    }
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

    if (!haveData && !isStartRecord) {
        self.startButton.enabled = YES;
        return;
    }

    if (isStartRecord) {
        self.stopButton.enabled = YES;
        self.cancelButton.enabled = YES;
        return;
    }

    if (haveData && !isStartRecord) {
        self.sendButton.enabled = YES;
        return;
    }
}

- (void)setSegmentStats {
    bool haveData = [accelerometerDataPackage.data count] > 0;

    self.phoneMovingSegment.enabled = NO;
    self.phonePositionSegment.enabled = NO;
    self.phoneSideSegment.enabled = NO;

    if (!haveData && !isStartRecord) {
        self.phoneMovingSegment.enabled = YES;
        if (self.phoneMovingSegment.selectedSegmentIndex == 0) {
            self.phonePositionSegment.enabled = NO;
            self.phoneSideSegment.enabled = NO;
        }
        return;
    } else {
        PhoneState phoneState = accelerometerDataPackage.phoneData.phoneState;
        NSInteger selectIndex = 0;

        if (phoneState & Stop) {
            selectIndex = 0;
            self.phonePositionSegment.enabled = NO;
            self.phoneSideSegment.enabled = NO;
        } else if (phoneState & Shake) {
            selectIndex = 1;
        } else if (phoneState & Run) {
            selectIndex = 2;
        } else if (phoneState & Walk) {
            selectIndex = 3;
        }
        self.phoneMovingSegment.selectedSegmentIndex = selectIndex;

        selectIndex = 0;
        if (phoneState & Left) {
            selectIndex = 0;
        } else if (phoneState & Right) {
            selectIndex = 1;
        }
        self.phoneSideSegment.selectedSegmentIndex = selectIndex;

        selectIndex = 0;
        if (phoneState & Handheld) {
            selectIndex = 0;
        } else if (phoneState & Using) {
            selectIndex = 1;
        } else if (phoneState & Pocket) {
            selectIndex = 2;
        } else if (phoneState & Handbag) {
            selectIndex = 3;
        } else if (phoneState & TrousersFrontPocket) {
            selectIndex = 4;
        } else if (phoneState & TrousersBackPocket) {
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

- (bool)sendDataPackage:(DataPackage *)dataPackage to:(NSString *)urlPath{
    NSString *json = [Utils convertObjectToJson:[dataPackage dictionary]];

    NSData *respond = nil;
    @try {
        respond = [Utils postCall:urlPath withJSON:json];
    }
    @catch (NSException *exception) {
    }

    NSString *respondString = [[NSString alloc] initWithData:respond encoding:NSUTF8StringEncoding];
    return [respondString isEqualToString:@""];
}

@end
