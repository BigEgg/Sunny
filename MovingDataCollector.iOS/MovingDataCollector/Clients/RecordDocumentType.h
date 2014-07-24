//
// Created by Jianming Xiao on 7/25/14.
// Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataPackage.h"

@interface RecordDocumentType : NSObject

- (void)saveDataPackage:(DataPackage *)dataPackage to:(NSString *)fileName;

- (DataPackage *)openRecordFile:(NSString *)fileName;

@end