//
//  Utils.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface Utils : NSObject

+ (NSString *)phoneStatusToString:(PhoneStatus)phoneStatus;

+ (NSString *)convertObjectToJson:(NSObject *)object;

+ (NSData *)postCall:(NSString *)urlPath withJSON:(NSString *)jsonData;

+ (NSData *)getCall:(NSString *)urlPath;

@end
