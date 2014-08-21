//
//  DrawPoint.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "DrawPoint.h"

@implementation DrawPoint

- (id)initWithX:(float)x Y:(float)y {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

@end
