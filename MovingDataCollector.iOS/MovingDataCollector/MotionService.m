//
//  MotionService.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "MotionService.h"
#import "AccelerometerData.h"
#import "GyroscopeData.h"

@implementation MotionService

- (instancetype)init
{
    self = [super init];
    if (self) {
        accelerometerHandlers = [NSMutableArray init];
        gyroscopeHandlers = [NSMutableArray init];
    }
    return self;
}

- (void)addAccelerometerHandler:(SEL)selector
{
    NSString *selectorString = NSStringFromSelector(selector);
    [accelerometerHandlers addObject:selectorString];
}

- (void)addGyroscopeHandler:(SEL)selector
{
    NSString *selectorString = NSStringFromSelector(selector);
    [gyroscopeHandlers addObject:selectorString];
}

- (void)initializeMotionManager
{
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
             AccelerometerData *data = [[AccelerometerData alloc] initWithX:acceleration.x
                                                                       andY:acceleration.y
                                                                       andZ:acceleration.z];
             
             for (NSString *selectorString in accelerometerHandlers) {
                 SEL handler = NSSelectorFromString(selectorString);
                 [self performSelector:handler withObject:data];
             }
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
             GyroscopeData *data = [[GyroscopeData alloc] initWithDeltaX:rotate.x
                                                               andDeltaY:rotate.y
                                                               andDeltaZ:rotate.z];
             
             for (NSString *selectorString in gyroscopeHandlers) {
                 SEL handler = NSSelectorFromString(selectorString);
                 [self performSelector:handler withObject:data];
             }
         }];
    }
    
}

@end
