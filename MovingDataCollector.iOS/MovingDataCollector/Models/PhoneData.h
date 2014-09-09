//
//  PhoneData.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJSONSerialize.h"
#import "Enums.h"

@interface PhoneData : NSObject <IJSONSerialize>

@property PhoneType phoneType;
@property PhoneState phoneState;
@property int updateInterval;

@end
