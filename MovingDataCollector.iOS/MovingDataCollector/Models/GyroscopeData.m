//
//  GyrometerData.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "GyroscopeData.h"

@implementation GyroscopeData
@synthesize deltaX, deltaY, deltaZ;

- (instancetype)init {
    self = [super init];
    if (self) {
        deltaX = 0.0;
        deltaY = 0.0;
        deltaZ = 0.0;
    }
    return self;
}

- (id)initWithDeltaX:(float)theDeltaX andDeltaY:(float)theDeltaY andDeltaZ:(float)theDeltaZ {
    self = [super init];
    if (self) {
        deltaX = theDeltaX;
        deltaY = theDeltaY;
        deltaZ = theDeltaZ;
    }
    return self;
}

- (NSString *)toString {
    NSString *deltaXString = [[NSString alloc] initWithFormat:@"%.4f", deltaX];
    NSString *deltaYString = [[NSString alloc] initWithFormat:@"%.4f", deltaY];
    NSString *deltaZString = [[NSString alloc] initWithFormat:@"%.4f", deltaZ];

    NSString *result = [[NSString alloc] initWithFormat:@"%@, %@, %@", deltaXString, deltaYString, deltaZString];

    return result;
}

@end
