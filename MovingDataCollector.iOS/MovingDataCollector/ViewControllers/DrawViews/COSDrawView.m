//
//  COSΘDrawView.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "COSDrawView.h"
#import "DrawPoint.h"

@implementation COSDrawView

#define COS_DRAW_VIEW_WIDTH 240
#define COS_DRAW_VIEW_HEIGHT 169

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cgContext = UIGraphicsGetCurrentContext();
    }
    return self;
}



@end
