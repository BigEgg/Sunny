//
//  COSΘDrawView.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "COSDrawView.h"

@implementation COSDrawView

- (id)initWithHeight:(int)theHeight Width:(int)theWidth {
    CGRect frame = CGRectMake(0, 0, theWidth, theHeight);
    self = [super initWithFrame:frame];
    if (self) {
        height = theHeight;
        width = theWidth;
        
        cosAlgorithm = [[COSAlgorithm alloc] init];
        cosDrawLogic = [[COSDrawLogic alloc] initWithHeight:height Width:width];
        index = 0;
        
        self.backgroundColor = [UIColor darkGrayColor];
    }
    return self;
}

#pragma mark - Drawing Methods

- (void)drawRect:(CGRect)rect {
    cgContext = UIGraphicsGetCurrentContext();
}

- (void)drawAccelerometerData:(AccelerometerData *)data {
    float newCOS = 0.0;
    if (lastAccelerometerData != nil) {
        newCOS = [cosAlgorithm computeWithData:data andOldData:lastAccelerometerData];
        [cosDrawLogic drawLineInContext:cgContext index:index++ startCOS:lastCOS endCOS:newCOS];
    }
    
    lastAccelerometerData = data;
    lastCOS = newCOS;
}

- (void)drawGyroscopeData:(GyroscopeData *)data {
    
}


@end
