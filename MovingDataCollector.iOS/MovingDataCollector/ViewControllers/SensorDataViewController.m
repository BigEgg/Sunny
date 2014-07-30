//
//  SensorDataViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "SensorDataViewController.h"

@interface SensorDataViewController ()

@end

@implementation SensorDataViewController

#pragma mark - View Controller Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

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
        default:
            break;
    }
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
