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
    float lenght1 = sqrtf(powf(data.x, 2) + powf(data.y, 2) + powf(data.z, 2));
    float lenght2 = sqrtf(powf(oldData.x, 2) + powf(oldData.y, 2) + powf(oldData.z, 2));
    
    return (data.x * oldData.x + data.y * oldData.y + data.z * oldData.z) / (lenght1 * lenght2);
}

@end
