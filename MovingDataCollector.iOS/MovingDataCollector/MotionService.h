//
//  MotionService.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "ISensorDataHandler.h"

@interface MotionService : NSObject
{
    NSMutableArray *handlers;
    
    CMMotionManager *motionManager;
    NSOperationQueue *accelerometerQueue;
    NSOperationQueue *gyroscopeQueue;
}

extern float const ACCELEROMETER_UPDATE_TIMES;
extern float const GYROSCOPE_UPDATE_TIMES;

- (void)addHandler:(id<ISensorDataHandler>)handler;

- (void)initializeMotionManager;

@end
