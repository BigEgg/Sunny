//
//  ViewController.h
//  MovingDataCollector
//
//  Created by jianming.xiao on 6/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *accelerometerQueue;
    NSOperationQueue *gyroscopeQueue;
}


@property (weak, nonatomic) IBOutlet UITextField *testName;

@property (weak, nonatomic) IBOutlet UILabel *xAccelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccelerometerLable;
@property (weak, nonatomic) IBOutlet UILabel *zAccelerometerLable;
@property (weak, nonatomic) IBOutlet UILabel *xGyroscopeLable;
@property (weak, nonatomic) IBOutlet UILabel *yGyroscopeLable;
@property (weak, nonatomic) IBOutlet UILabel *zGyroscopeLable;

@property (weak, nonatomic) IBOutlet UIProgressView *xAccelerometerBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yAccelerometerBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zAccelerometerBar;
@property (weak, nonatomic) IBOutlet UIProgressView *xGyroscopeBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yGyroscopeBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zGyroscopeBar;

@property (weak, nonatomic) IBOutlet UIButton *record;

@end
