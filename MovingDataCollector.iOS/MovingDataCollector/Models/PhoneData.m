//
//  PhoneData.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "PhoneData.h"

@implementation PhoneData

- (NSDictionary *)dictionary {
    return @{@"PhoneType" : @(self.phoneType),
            @"PhoneStatus" : @(self.phoneStats),
            @"UpdateInterval" : @(self.updateInterval)};
}

@end
