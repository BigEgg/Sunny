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

extern NSString * const RecordFileExtension;

+ (NSString *)phoneStatusToString:(PhoneStatus)phoneStatus;

+ (NSString *)getFilePath:(NSString *)fileName;

+ (NSArray *)getAllFilesName;

@end
