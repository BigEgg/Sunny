//
//  COSLogic.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "COSLogic.h"

@implementation COSLogic
@synthesize height, width;

float const DATA_WIDTH_PIXEL = 5;
float const LINE_WIDTH = 1;
UIColor * DATA_LINE_COLOR;
UIColor * BACKGROUND_COLOR;

- (id)initWithHeight:(int)theHeight Width:(int)theWidth {
    self = [super init];
    if (self) {
        height = theHeight;
        width = theWidth;
        
        DATA_LINE_COLOR = [UIColor yellowColor];
        BACKGROUND_COLOR = [UIColor darkGrayColor];
    }
    return self;
}

- (void)drawLineInContext:(CGContextRef)context
                    index:(int)index
                 startCOS:(float)startCOS
                   endCOS:(float)endCOS {
    DrawPoint *backgroundStartPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 3) Y:startCOS];
    DrawPoint *backgroundEndPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 3) Y:endCOS];
    
    [self drawStraightLinesInContext:context color:BACKGROUND_COLOR startPoint:backgroundStartPoint endPoint:backgroundEndPoint lineWidth:DATA_WIDTH_PIXEL];
    
    DrawPoint *lineStartPoint = [[DrawPoint alloc] initWithX:((index - 1) * DATA_WIDTH_PIXEL + 1) Y:startCOS];
    DrawPoint *lineEndPoint = [[DrawPoint alloc] initWithX:(index * DATA_WIDTH_PIXEL) Y:endCOS];
    
    [self drawStraightLinesInContext:context color:DATA_LINE_COLOR startPoint:lineStartPoint endPoint:lineEndPoint lineWidth:LINE_WIDTH];
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
