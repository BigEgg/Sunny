//
//  Utils.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "Utils.h"

@implementation Utils

#pragma mark - Enum

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
    else if (phoneStatus & Using) {
        [result appendString:@"_Using"];
    }
    else if (phoneStatus & Pocket) {
        [result appendString:@"_Pocket"];
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

+ (NSString *)convertObjectToJson:(NSObject *)object {
    NSError *writeError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return result;
}

+ (bool)postCall:(NSString *)urlPath withJSON:(NSString *)jsonData {
    return false;
}

+ (NSData *)getCall:(NSString *)urlPath {
    NSURL *url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
}

@end
