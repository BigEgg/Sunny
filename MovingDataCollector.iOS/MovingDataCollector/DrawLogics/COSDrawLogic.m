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

float const DATA_WIDTH_PIXEL = 5;
float const LINE_WIDTH = 1;
int const DIAGRAM_MARGIN = 10;
UIColor * DATA_LINE_COLOR;
UIColor * BACKGROUND_COLOR;
int dataWidth;
int halfHeight;

- (id)initWithHeight:(int)theHeight Width:(int)theWidth {
    self = [super init];
    if (self) {
        height = theHeight;
        width = theWidth;
        halfHeight = height / 2 - DIAGRAM_MARGIN * 2;
        
        dataWidth = theWidth / DATA_WIDTH_PIXEL;
        
        DATA_LINE_COLOR = [UIColor yellowColor];
        BACKGROUND_COLOR = [UIColor darkGrayColor];
    }
    return self;
}

- (void)drawLineInContext:(CGContextRef)context
                    index:(int)index
                 startCOS:(float)startCOS
                   endCOS:(float)endCOS {
    index = index % dataWidth;
    
    DrawPoint *backgroundStartPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 3)
                                                                 Y:0];
    DrawPoint *backgroundEndPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 3)
                                                               Y:height];
    
    [self drawStraightLinesInContext:context
                               color:BACKGROUND_COLOR
                          startPoint:backgroundStartPoint
                            endPoint:backgroundEndPoint
                           lineWidth:DATA_WIDTH_PIXEL];
    
    DrawPoint *lineStartPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 1)
                                                           Y:halfHeight + startCOS * halfHeight];
    DrawPoint *lineEndPoint = [[DrawPoint alloc] initWithX:(index * DATA_WIDTH_PIXEL)
                                                         Y:halfHeight + endCOS * halfHeight];
    
    [self drawStraightLinesInContext:context
                               color:DATA_LINE_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:LINE_WIDTH];
}

#pragma mark - Private Methods
- (void)drawStraightLinesInContext:(CGContextRef)context
                             color:(UIColor *)color
                        startPoint:(DrawPoint *)startPoint
                          endPoint:(DrawPoint *)endPoint
                         lineWidth:(float)lineWidth  {
    UIGraphicsPushContext(context);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.X, startPoint.Y);
    CGContextAddLineToPoint(context, endPoint.X, endPoint.Y);
    CGContextSetLineWidth(context, lineWidth);
    [color setStroke];
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

@end
