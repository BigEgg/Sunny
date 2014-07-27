//
//  RecordDetailViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordDetailViewController.h"

@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController

@synthesize accelerometerDataPackage, gyroscopeDataPackage;

#pragma mark - View LifeCycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.accelerometerDataPackage = [[DataPackage alloc] init];
        self.accelerometerDataPackage.phoneData = [[PhoneData alloc] init];
        self.accelerometerDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        self.accelerometerDataPackage.phoneData.phoneStats = Stop;

        self.gyroscopeDataPackage = [[DataPackage alloc] init];
        self.gyroscopeDataPackage.phoneData = [[PhoneData alloc] init];
        self.gyroscopeDataPackage.data = (NSMutableArray <ISensorData> *) [[NSMutableArray alloc] init];
        self.gyroscopeDataPackage.phoneData.phoneStats = Stop;

        self.isSentRecord = NO;
        self.isStartRecord = YES;
        
        [self setButtonsStats];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (!self.viewTitle) {
        self.title = @"New Record";
    } else {
        self.title = self.viewTitle;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)phoneStatusChanged:(id)sender {
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

    [self setButtonsStats];
}

- (IBAction)startRecord:(id)sender {
    self.isStartRecord = YES;
    
    [self setButtonsStats];
}

- (IBAction)cancelRecord:(id)sender {
    self.isStartRecord = NO;
    [self.accelerometerDataPackage.data removeAllObjects];
    [self.gyroscopeDataPackage.data removeAllObjects];
    
    [self setButtonsStats];
}

- (IBAction)sendRecord:(id)sender {
    self.isSentRecord = YES;
    
    [self setButtonsStats];
}

#pragma mark - Private Methods
- (void)setButtonsStats
{
    bool haveData = [self.accelerometerDataPackage.data count];
    
    self.startButton.enabled = NO;
    self.stopButton.enabled = NO;
    self.cancelButton.enabled = NO;
    self.sendButton.enabled = NO;
    
    if (!haveData) {
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


@end
