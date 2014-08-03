//
//  SensorDataViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "SensorDataViewController.h"
#import "Utils.h"
#import "Constants.h"

@interface SensorDataViewController ()

@end

@implementation SensorDataViewController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.sectionView addSubview:self.accelerometerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.accelerometerView];
            break;
        case 1:
            [self.sectionView addSubview:self.gyroscopeView];
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Section View Segment is invalid, index: %ld",
                               (long) sectionControl.selectedSegmentIndex];
    }
}

- (IBAction)testConnection:(id)sender {
    NSString *urlPath = [[NSString alloc] initWithFormat:@"%s%s", SUNNY_SERVER, SUNNY_API_TEST_CONNECTION];

    NSData *respond = nil;
    @try {
        respond = [Utils getCall:urlPath];
    }
    @catch (NSException *exception) {
    }

    if (respond != nil) {
        NSString *sespondString = [[NSString alloc] initWithData:respond encoding:NSUTF8StringEncoding];
        NSLog(@"%@", sespondString);
        if ([sespondString isEqual:@"\"Can connect.\""]) {
            self.connectionResultLable.text = @"Success";
            return;
        }
    }
    
    self.connectionResultLable.text = @"Cannot";
}

#pragma mark - Sensor Data Handlers

- (void)accelerometerHandler:(AccelerometerData *)data {
    _xAccelerometerLabel.text = [NSString stringWithFormat:@"%f", data.x];
    _xAccelerometerBar.progress = ABS(data.x);

    _yAccelerometerLable.text = [NSString stringWithFormat:@"%f", data.y];
    _yAccelerometerBar.progress = ABS(data.y);

    _zAccelerometerLable.text = [NSString stringWithFormat:@"%f", data.z];
    _zAccelerometerBar.progress = ABS(data.z);
}


- (void)gyroscopeHandler:(GyroscopeData *)data {
    _xGyroscopeLable.text = [NSString stringWithFormat:@"%f", data.deltaX];
    _xGyroscopeBar.progress = ABS(data.deltaX);

    _yGyroscopeLable.text = [NSString stringWithFormat:@"%f", data.deltaY];
    _yGyroscopeBar.progress = ABS(data.deltaY);

    _zGyroscopeLable.text = [NSString stringWithFormat:@"%f", data.deltaZ];
    _zGyroscopeBar.progress = ABS(data.deltaZ);
}

@end
