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
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0 / 5.0; //  Update at 5Hz
    motionManager.gyroUpdateInterval = 1.0 / 5.0; //  Update at 5Hz
    
    if (motionManager.accelerometerAvailable)
    {
        accelerometerQueue = [NSOperationQueue currentQueue];
        [motionManager startAccelerometerUpdatesToQueue: accelerometerQueue
                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
                                                {
                                                    CMAcceleration acceleration = accelerometerData.acceleration;

                                                    _xAccelerometerLabel.text = [NSString stringWithFormat:@"%f", acceleration.x];
                                                    _xAccelerometerBar.progress = ABS(acceleration.x);

                                                    _yAccelerometerLable.text = [NSString stringWithFormat:@"%f", acceleration.y];
                                                    _yAccelerometerBar.progress = ABS(acceleration.y);

                                                    _zAccelerometerLable.text = [NSString stringWithFormat:@"%f", acceleration.z];
                                                    _zAccelerometerBar.progress = ABS(acceleration.z);
                                                }];
    }
    if (motionManager.gyroAvailable)
    {
        NSLog(@"Gyroscope avaliable.");
        gyroscopeQueue = [NSOperationQueue currentQueue];
        [motionManager startGyroUpdatesToQueue: gyroscopeQueue
                                   withHandler:^(CMGyroData *gyroData, NSError *error)
                                                {
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

#pragma mark - Actions
- (IBAction)sectionChanged:(id)sender
{
    UISegmentedControl *sectionControl = (UISegmentedControl *)sender;
    if (sectionControl.selectedSegmentIndex == 0)       // Colors section
        [self.sectionView addSubview:self.accelerometerView];
    else if (sectionControl.selectedSegmentIndex == 1)  // Progress section
        [self.sectionView addSubview:self.gyroscopeView];
}
@end
