//
//  COSLogic.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawPoint.h"

@interface COSDrawLogic : NSObject {
    UIColor * DATA_LINE_COLOR;
    UIColor * BACKGROUND_COLOR;
    
    int dataWidth;
    int halfHeight;
}

@property int height;
@property int width;

- (id)initWithHeight:(int)height Width:(int)width;

- (CGRect)drawLineInContext:(CGContextRef)context
                    index:(int)index
                 startCOS:(float)startCOS
                   endCOS:(float)endCOS;

@end
