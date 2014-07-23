//
//  SensorDataViewController.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccelerometerData.h"
#import "GyroscopeData.h"

@interface SensorDataViewController : UIViewController
{
@public
    SEL accelerometerHandlerSelector;
    SEL gyroscopeHandlerSelector;
}

@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet UIView *accelerometerView;
@property (strong, nonatomic) IBOutlet UIView *gyroscopeView;

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


- (IBAction)sectionChanged:(id)sender;

@end
