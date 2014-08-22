//
//  COSΘDrawView.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDrawView.h"
#import "COSAlgorithm.h"

@interface COSDrawView : UIView <IDrawView> {
    int height, width;
    
    CGContextRef cgContext;
    
    COSAlgorithm *cosAlgorithm;
    
    AccelerometerData *lastAccelerometerData;
    float newCOS;
    float lastCOS;
    int index;
    
    UIColor *DATA_LINE_COLOR;
    UIColor *BACKGROUND_COLOR;
    UIColor *GRID_COLOR;
    
    int dataWidth;
    int halfHeight;
}

@end
