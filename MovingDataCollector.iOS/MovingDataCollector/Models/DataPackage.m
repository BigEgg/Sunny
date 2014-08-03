//
//  DataPackage.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "DataPackage.h"
#import "Utils.h"

@implementation DataPackage

- (NSDictionary *)dictionary {
    NSMutableArray *dataJSON = [[NSMutableArray alloc] init];

    for (id <ISensorData> entity in self.data) {
        [dataJSON addObject:[entity dictionary]];
    }

    return @{@"PhoneData" : [self.phoneData dictionary],
            @"Data" : dataJSON};
}

@end
