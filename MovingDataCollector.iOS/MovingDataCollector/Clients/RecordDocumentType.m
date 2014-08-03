//
// Created by Jianming Xiao on 7/25/14.
// Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordDocumentType.h"


@implementation RecordDocumentType {
}

static NSString * const ENCODE_KEY = @"dataPackage";

- (void)saveDataPackage:(DataPackage *)dataPackage to:(NSString *)fileName {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dataPackage forKey:ENCODE_KEY];
    [archiver finishEncoding];
    NSString *dataPath = [self getFilePath:fileName];
    [data writeToFile:dataPath atomically:YES];
}

- (DataPackage *)openRecordFile:(NSString *)fileName {
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:[self getFilePath:fileName]];
    NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    return [decoder decodeObjectForKey:ENCODE_KEY];
}

#pragma mark - Private Methods

- (NSString *)getFilePath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    return [documentsDirectoryPath stringByAppendingPathComponent:fileName];
}

@end