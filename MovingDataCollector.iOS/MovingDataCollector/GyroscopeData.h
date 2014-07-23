//
//  GyrometerData.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISensorData.h"

@interface GyroscopeData : NSObject <ISensorData>

@property float deltaX, deltaY, deltaZ;

- (id)initWithDeltaX:(float)theDeltaX andDeltaY:(float)theDeltaY andDeltaZ:(float)theDeltaZ;

- (NSString *)toString;

@end
