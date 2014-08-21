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
#import "COSDrawLogic.h"

@interface COSDrawView : UIView <IDrawView> {
    int height, width;
    
    CGContextRef cgContext;
    
    COSAlgorithm *cosAlgorithm;
    COSDrawLogic *cosDrawLogic;
    
    AccelerometerData *lastAccelerometerData;
    float lastCOS;
    int index;
}

@end
