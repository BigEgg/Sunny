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

float const DATA_WIDTH_PIXEL = 3;
float const LINE_WIDTH = 1.5;
float const GRID_WIDTH = 0.5;
int const DIAGRAM_MARGIN = 10;

- (id)initWithHeight:(int)theHeight Width:(int)theWidth {
    CGRect frame = CGRectMake(0, 0, theWidth, theHeight);
    self = [super initWithFrame:frame];
    if (self) {
        height = theHeight;
        width = theWidth;
        
        cosAlgorithm = [[COSAlgorithm alloc] init];
        index = 0;
        lastCOS = 0;
        
        halfHeight = height / 2;
        dataWidth = width / DATA_WIDTH_PIXEL;
        
        DATA_LINE_COLOR = [UIColor yellowColor];
        BACKGROUND_COLOR = [UIColor darkGrayColor];
        GRID_COLOR = [UIColor lightGrayColor];
    }
    return self;
}

#pragma mark - Drawing Methods

- (void)drawRect:(CGRect)rect {
    self.clearsContextBeforeDrawing = NO;
    cgContext = UIGraphicsGetCurrentContext();
    [self drawDataInContext:cgContext startCOS:lastCOS endCOS:newCOS];
    index++;
    lastCOS = newCOS;
}

- (void)drawAccelerometerData:(AccelerometerData *)data {
    newCOS = 0.0;
    if (lastAccelerometerData != nil) {
        newCOS = [cosAlgorithm computeWithData:data andOldData:lastAccelerometerData];

        index = index % dataWidth;
        CGRect background = CGRectMake(index * DATA_WIDTH_PIXEL, 0, DATA_WIDTH_PIXEL, height);
        [self setNeedsDisplayInRect:background];
    }
    
    lastAccelerometerData = data;
}

- (void)drawGyroscopeData:(GyroscopeData *)data {
    
}

#pragma mark - Private Drawing Methods

- (CGRect)drawDataInContext:(CGContextRef)context
                   startCOS:(float)startCOS
                     endCOS:(float)endCOS {
    DrawPoint *lineStartPoint = [[DrawPoint alloc] initWithX:(index * DATA_WIDTH_PIXEL)
                                                           Y:halfHeight + startCOS * (halfHeight - DIAGRAM_MARGIN) ];
    DrawPoint *lineEndPoint = [[DrawPoint alloc] initWithX:((index + 1) * DATA_WIDTH_PIXEL)
                                                         Y:halfHeight + endCOS * (halfHeight - DIAGRAM_MARGIN)];
    CGRect background = CGRectMake(lineStartPoint.X, 0, DATA_WIDTH_PIXEL, height);
    
    UIGraphicsPushContext(context);
    
    //  Draw background
    [self drawRectangle:context
                  color:BACKGROUND_COLOR
                   rect:background];
    
    //  Draw data
    [self drawStraightLinesInContext:context
                               color:DATA_LINE_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:LINE_WIDTH];
    
    //  Draw grid
    lineStartPoint.y = lineEndPoint.y = halfHeight + halfHeight - DIAGRAM_MARGIN;
    [self drawStraightLinesInContext:context
                               color:GRID_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:GRID_WIDTH];

    lineStartPoint.y = lineEndPoint.y = halfHeight;
    [self drawStraightLinesInContext:context
                               color:GRID_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:GRID_WIDTH];
    
    lineStartPoint.y = lineEndPoint.y = DIAGRAM_MARGIN;
    [self drawStraightLinesInContext:context
                               color:GRID_COLOR
                          startPoint:lineStartPoint
                            endPoint:lineEndPoint
                           lineWidth:GRID_WIDTH];

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
