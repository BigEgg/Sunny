//
//  AccelerometerData.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "AccelerometerData.h"

@implementation AccelerometerData 
@synthesize x, y, z;

- (instancetype)init
{
    self = [super init];
    if (self) {
        x = 0.0;
        y = 0.0;
        z = 0.0;
    }
    return self;
}

- (instancetype)initWithX:(float)theX andY:(float)theY andZ:(float)theZ
{
    self = [super init];
    if (self) {
        x = theX;
        y = theY;
        z = theZ;
    }
    return self;
}

- (NSString *)toString
{
    NSString *xString = [[NSString alloc] initWithFormat:@"%.4f", x];
    NSString *yString = [[NSString alloc] initWithFormat:@"%.4f", y];
    NSString *zString = [[NSString alloc] initWithFormat:@"%.4f", z];
    
    NSString *result = [[NSString alloc] initWithFormat:@"%@, %@, %@", xString, yString, zString];
    
    return result;
}

@end
