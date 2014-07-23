//
//  AccelerometerData.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISensorData.h"

@interface AccelerometerData : NSObject <ISensorData>

@property float x, y, z;

- (id)initWithX:(float)theX andY:(float)theY andZ:(float)theZ;

- (NSString *)toString;

@end
