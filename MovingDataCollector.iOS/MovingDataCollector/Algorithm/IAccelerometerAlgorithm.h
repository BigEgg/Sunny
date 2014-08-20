//
//  IAccelemeterAlgorithm.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAlgorithm.h"
#import "AccelerometerData.h"

@protocol IAccelerometerAlgorithm <NSObject, IAlgorithm>

- (float)computeWithData:(AccelerometerData *)data andOldData:(AccelerometerData *)oldData；

@end
