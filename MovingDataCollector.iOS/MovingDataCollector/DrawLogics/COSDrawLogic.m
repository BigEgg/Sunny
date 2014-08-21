//
//  COSLogic.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "COSDrawLogic.h"

@implementation COSDrawLogic
@synthesize height, width;

float const DATA_WIDTH_PIXEL = 10;
float const LINE_WIDTH = 3;
int const DIAGRAM_MARGIN = 10;


- (id)initWithHeight:(int)theHeight Width:(int)theWidth {
    self = [super init];
    if (self) {
        height = theHeight * 2;
        width = theWidth * 2;

        halfHeight = height / 2 - DIAGRAM_MARGIN * 2;
        dataWidth = width / DATA_WIDTH_PIXEL;
        
        DATA_LINE_COLOR = [UIColor yellowColor];
        BACKGROUND_COLOR = [UIColor darkGrayColor];
    }
    return self;
}

- (CGRect)drawLineInContext:(CGContextRef)context
                    index:(int)index
                 startCOS:(float)startCOS
                   endCOS:(float)endCOS {
    index = index % dataWidth;
    
    DrawPoint *lineStartPoint = [[DrawPoint alloc] initWithX:(index * DATA_WIDTH_PIXEL + 1)
                                                           Y:halfHeight + startCOS * halfHeight];
    DrawPoint *lineEndPoint = [[DrawPoint alloc] initWithX:((index + 1) * DATA_WIDTH_PIXEL)
                                                         Y:halfHeight + endCOS * halfHeight];
    CGRect background = CGRectMake(lineStartPoint.X, 0, DATA_WIDTH_PIXEL, height);
    
    UIGraphicsPushContext(context);
    [self drawRectangle:context
                  color:BACKGROUND_COLOR
                   rect:background];
    [self drawStraightLinesInContext:context
                               color:DATA_LINE_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:LINE_WIDTH];
    UIGraphicsPopContext();

    return background;
}

#pragma mark - Private Methods
- (void)drawStraightLinesInContext:(CGContextRef)context
                             color:(UIColor *)color
                        startPoint:(DrawPoint *)startPoint
                          endPoint:(DrawPoint *)endPoint
                         lineWidth:(float)lineWidth  {
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.X, startPoint.Y);
    CGContextAddLineToPoint(context, endPoint.X, endPoint.Y);
    CGContextSetLineWidth(context, lineWidth);
    [color setStroke];
    CGContextStrokePath(context);
    CGContextSetLineCap(context, kCGLineCapRound);
}

- (void)drawRectangle:(CGContextRef)context color:(UIColor *)color rect:(CGRect)rect {
    CGContextBeginPath(context);
	CGContextAddRect(context, rect);
	[color setFill];
	CGContextDrawPath(context, kCGPathFill);
}

@end
