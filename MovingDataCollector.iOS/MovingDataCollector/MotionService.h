//
//  MotionService.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MotionService : NSObject
{
    NSMutableArray *accelerometerHandlers;
    NSMutableArray *gyroscopeHandlers;
    
    CMMotionManager *motionManager;
    NSOperationQueue *accelerometerQueue;
    NSOperationQueue *gyroscopeQueue;
}

- (void)addAccelerometerHandler:(SEL)selector;
- (void)addGyroscopeHandler:(SEL)selector;

- (void)initializeMotionManager;

@end
