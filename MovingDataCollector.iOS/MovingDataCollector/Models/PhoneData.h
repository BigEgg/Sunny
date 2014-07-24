//
//  PhoneData.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface PhoneData : NSObject

@property PhoneType phoneType;
@property PhoneStatus phoneStats;
@property int updateInterval;

@end
