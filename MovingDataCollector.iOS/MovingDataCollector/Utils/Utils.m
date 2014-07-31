//
//  Utils.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static NSString *defaultFolderName = @"";
NSString *const RecordFileExtension = @"record";       //  Update at 5Hz

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

#pragma mark - Document

+ (NSString *)getFilePath:(NSString *)fileName {
    if ([fileName substringFromIndex:fileName.length - RecordFileExtension.length - 1] != RecordFileExtension) {
        fileName = [fileName stringByAppendingString:RecordFileExtension];
    }

    NSString *documentsDirectoryPath = [self getDirectoryPath];
    return [documentsDirectoryPath stringByAppendingPathComponent:fileName];
}

+ (NSArray *)getAllFilesName {
    NSArray *dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self getDirectoryPath]
                                                                        error:NULL];
    NSMutableArray *filesName = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *) obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:RecordFileExtension]) {
            [filesName addObject:filename];
        }
    }];
    return filesName;
}

+ (NSString *)getDirectoryPath {
    if ([defaultFolderName length] == 0) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        if ([paths count] > 0) {
            defaultFolderName = paths[0];
        }
    }
    return defaultFolderName;
}

@end
