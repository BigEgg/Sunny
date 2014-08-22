//
//  COSAlgorithm.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "COSAlgorithm.h"
#import <math.h>

@implementation COSAlgorithm

- (float)computeWithData:(AccelerometerData *)data andOldData:(AccelerometerData *)oldData {
    return (data.x * oldData.x + data.y * oldData.y + data.z * oldData.z);
}

@end
