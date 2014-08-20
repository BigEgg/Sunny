//
//  IDrawView.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/20/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccelerometerData.h"
#import "GyroscopeData.h"

@protocol IDrawView <NSObject>

- (id)initWithHeight:(int)theHeight Width:(int)theWidth;

- (void)drawAccelerometerData:(AccelerometerData *)data;
- (void)drawGyroscopeData:(GyroscopeData *)data;

@end
