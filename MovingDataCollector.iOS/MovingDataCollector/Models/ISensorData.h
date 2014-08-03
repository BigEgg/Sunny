//
//  ISensorData.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJSONSerialize.h"

@protocol ISensorData <NSObject, IJSONSerialize>

- (NSString *)toString;

@end
