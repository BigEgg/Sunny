//
//  COSLogic.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/19/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawPoint.h"

@interface COSLogic : NSObject

@property int height;
@property int width;

- (id)initWithHeight:(int)height Width:(int)width;

- (void)drawLineInContext:(CGContextRef)context
                    index:(int)index
                 startCOS:(float)startCOS
                   endCOS:(float)endCOS;

@end
