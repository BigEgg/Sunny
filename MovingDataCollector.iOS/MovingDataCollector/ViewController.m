//
//  ViewController.m
//  MovingDataCollector
//
//  Created by jianming.xiao on 6/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0 / 4.0; //  Update at 2Hz
    motionManager.gyroUpdateInterval = 1.0 / 4.0; //  Update at 2Hz
    
    if (motionManager.accelerometerAvailable) {
        accelerometerQueue = [NSOperationQueue currentQueue];
        [motionManager startAccelerometerUpdatesToQueue: accelerometerQueue
            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                CMAcceleration acceleration = accelerometerData.acceleration;
                
                _xAccelerometerLabel.text = [NSString stringWithFormat:@"%f", acceleration.x];
                _xAccelerometerBar.progress = ABS(acceleration.x);
                
                _yAccelerometerLable.text = [NSString stringWithFormat:@"%f", acceleration.y];
                _yAccelerometerBar.progress = ABS(acceleration.y);
                
                _zAccelerometerLable.text = [NSString stringWithFormat:@"%f", acceleration.z];
                _zAccelerometerBar.progress = ABS(acceleration.z);
            }];
    }
    if (motionManager.gyroAvailable) {
        NSLog(@"Gyroscope avaliable.");
        gyroscopeQueue = [NSOperationQueue currentQueue];
        [motionManager startGyroUpdatesToQueue: gyroscopeQueue
            withHandler:^(CMGyroData *gyroData, NSError *error) {
                CMRotationRate rotate = gyroData.rotationRate;
                
                _xGyroscopeLable.text = [NSString stringWithFormat:@"%f", rotate.x];
                _xGyroscopeBar.progress = ABS(rotate.x);
                
                _yGyroscopeLable.text = [NSString stringWithFormat:@"%f", rotate.y];
                _yGyroscopeBar.progress = ABS(rotate.y);
                
                _zGyroscopeLable.text = [NSString stringWithFormat:@"%f", rotate.z];
                _zGyroscopeBar.progress = ABS(rotate.z);
            }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
