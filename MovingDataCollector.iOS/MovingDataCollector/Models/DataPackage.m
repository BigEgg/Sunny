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
    NSString *phoneDataJSON = [Utils convertObjectToJson:[self.phoneData dictionary]];
    NSMutableArray *dataJSON = [[NSMutableArray alloc] init];

    for (id <ISensorData> entity in self.data) {
        [dataJSON addObject:[Utils convertObjectToJson:[entity dictionary]]];
    }

    return @{@"PhoneData" : phoneDataJSON,
            @"Data" : dataJSON};
}

@end
