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
    NSString *result = nil;

    if ((phoneStatus & Stop) == Stop) {
        result = @"Stop";
    }
    else if ((phoneStatus & Shake) == Shake) {
        result = @"Shake";
    }
    else if ((phoneStatus & Run) == Run) {
        result = @"Run";
    }
    else if ((phoneStatus & Walk) == Walk) {
        result = @"Walk";
    }

    if ((phoneStatus & Left) == Left) {
        result = [result initWithFormat:@"%@_%@", result, @"Left"];
    }
    else if ((phoneStatus & Right) == Right) {
        result = [result initWithFormat:@"%@_%@", result, @"Right"];
    }

    if ((phoneStatus & Handheld) == Handheld) {
        result = [result initWithFormat:@"%@_%@", result, @"Handheld"];
    }
    else if ((phoneStatus & HandheldUsing) == HandheldUsing) {
        result = [result initWithFormat:@"%@_%@", result, @"HandheldUsing"];
    }
    else if ((phoneStatus & BackPocket) == BackPocket) {
        result = [result initWithFormat:@"%@_%@", result, @"BackPocket"];
    }
    else if ((phoneStatus & Handbag) == Handbag) {
        result = [result initWithFormat:@"%@_%@", result, @"Handbag"];
    }
    else if ((phoneStatus & TrousersFrontPocket) == TrousersFrontPocket) {
        result = [result initWithFormat:@"%@_%@", result, @"TrousersFrontPocket"];
    }
    else if ((phoneStatus & TrousersBackPocket) == TrousersBackPocket) {
        result = [result initWithFormat:@"%@_%@", result, @"TrousersBackPocket"];
    }

    return result;
}

@end
