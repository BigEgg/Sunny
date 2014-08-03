//
//  DataPackage.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISensorData.h"
#import "PhoneData.h"

@interface DataPackage : NSObject <IJSONSerialize>

@property PhoneData *phoneData;
@property NSMutableArray <ISensorData> *data;

@end
