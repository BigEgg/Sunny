//
//  ISensorDataHandler.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelerometerData.h"
#import "GyroscopeData.h"

@protocol ISensorDataHandler <NSObject>

- (void)accelerometerHandler:(AccelerometerData *)data;

- (void)gyroscopeHandler:(GyroscopeData *)data;

@end
