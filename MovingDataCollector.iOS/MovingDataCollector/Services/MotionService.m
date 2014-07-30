//
//  MotionService.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "MotionService.h"
#import "RecordDetailViewController.h"

@implementation MotionService

float const ACCELEROMETER_UPDATE_TIMES = 5.0;       //  Update at 5Hz
float const GYROSCOPE_UPDATE_TIMES = 5.0;           //  Update at 5Hz

- (instancetype)init {
    self = [super init];
    if (self) {
        handlers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addHandler:(id <ISensorDataHandler>)handler {
    [handlers addObject:handler];
}

- (void)removeRecordDetailhandlers {
    for (id <ISensorDataHandler> handler in handlers) {
        if ([handler isKindOfClass:[RecordDetailViewController class]]) {
            [handlers removeObject:handler];
        }
    }
}

- (void)initializeMotionManager {
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0 / ACCELEROMETER_UPDATE_TIMES;
    motionManager.gyroUpdateInterval = 1.0 / GYROSCOPE_UPDATE_TIMES;

    if (motionManager.accelerometerAvailable) {
        accelerometerQueue = [NSOperationQueue currentQueue];
        [motionManager startAccelerometerUpdatesToQueue:accelerometerQueue
                                            withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
                {
                    CMAcceleration acceleration = accelerometerData.acceleration;
                    AccelerometerData *data = [[AccelerometerData alloc] initWithX:acceleration.x
                                                                              andY:acceleration.y
                                                                              andZ:acceleration.z];

                    for (id <ISensorDataHandler> handler in handlers) {
                        [handler accelerometerHandler:data];
                    }
                }];
    }
    if (motionManager.gyroAvailable) {
        NSLog(@"Gyroscope avaliable.");
        gyroscopeQueue = [NSOperationQueue currentQueue];
        [motionManager startGyroUpdatesToQueue:gyroscopeQueue
                                   withHandler:^(CMGyroData *gyroData, NSError *error)
                {
                    CMRotationRate rotate = gyroData.rotationRate;
                    GyroscopeData *data = [[GyroscopeData alloc] initWithDeltaX:rotate.x
                                                                      andDeltaY:rotate.y
                                                                      andDeltaZ:rotate.z];

                    for (id <ISensorDataHandler> handler in handlers) {
                        [handler gyroscopeHandler:data];
                    }
                }];
    }

}

@end
