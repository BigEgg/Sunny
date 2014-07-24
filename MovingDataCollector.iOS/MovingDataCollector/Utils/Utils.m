//
//  Utils.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)phoneStatusToString:(PhoneStatus)phoneStatus {
    NSMutableString *result = [NSMutableString stringWithCapacity:32];

    if (phoneStatus == Stop) {
        [result setString:@"Stop"];
        return result;
    }
    
    if (phoneStatus & Shake) {
        [result setString:@"Shake"];
    }
    else if (phoneStatus & Run) {
        [result setString:@"Run"];
    }
    else if (phoneStatus & Walk) {
        [result setString:@"Walk"];
    }

    if (phoneStatus & Left) {
        [result appendString:@"_Left"];
    }
    else if (phoneStatus & Right) {
        [result appendString:@"_Right"];
    }

    if (phoneStatus & Handheld) {
        [result appendString:@"_Handheld"];
    }
    else if (phoneStatus & HandheldUsing) {
        [result appendString:@"_HandheldUsing"];
    }
    else if (phoneStatus & BackPocket) {
        [result appendString:@"_BackPocket"];
    }
    else if (phoneStatus & Handbag) {
        [result appendString:@"_Handbag"];
    }
    else if (phoneStatus & TrousersFrontPocket) {
        [result appendString:@"_TrousersFrontPocket"];
    }
    else if (phoneStatus & TrousersBackPocket) {
        [result appendString:@"_TrousersBackPocket"];
    }

    return result;
}

@end
