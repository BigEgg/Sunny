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

    if ((phoneStatus & Stop) == Stop) {
        [result setString:@"Stop"];
    }
    else if ((phoneStatus & Shake) == Shake) {
        [result setString:@"Shake"];
    }
    else if ((phoneStatus & Run) == Run) {
        [result setString:@"Run"];
    }
    else if ((phoneStatus & Walk) == Walk) {
        [result setString:@"Walk"];
    }

    if ((phoneStatus & Left) == Left) {
        [result appendString:@"_Left"];
    }
    else if ((phoneStatus & Right) == Right) {
        [result appendString:@"_Right"];
    }

    if ((phoneStatus & Handheld) == Handheld) {
        [result appendString:@"_Handheld"];
    }
    else if ((phoneStatus & HandheldUsing) == HandheldUsing) {
        [result appendString:@"_HandheldUsing"];
    }
    else if ((phoneStatus & BackPocket) == BackPocket) {
        [result appendString:@"_BackPocket"];
    }
    else if ((phoneStatus & Handbag) == Handbag) {
        [result appendString:@"_Handbag"];
    }
    else if ((phoneStatus & TrousersFrontPocket) == TrousersFrontPocket) {
        [result appendString:@"_TrousersFrontPocket"];
    }
    else if ((phoneStatus & TrousersBackPocket) == TrousersBackPocket) {
        [result appendString:@"_TrousersBackPocket"];
    }

    return result;
}

@end
