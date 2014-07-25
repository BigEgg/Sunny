//
//  Enums.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/22/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PhoneType) {
    iPhone4 = 1001,
    iPhone4S = 1002,
    iPhone5 = 1011,
    iPhone5S = 1012
};

typedef NS_ENUM(NSUInteger, SensorData) {
    Accelerometer = 1,
    Gyroscope = 2
};

typedef NS_ENUM(NSUInteger, PhoneStatus) {
    None = 0x0,
    
    Stop = 0x1,
    Shake = 0x2,
    Run = 0x4,
    Walk = 0x8,

    Left = 0x10,
    Right = 0x20,

    Handheld = 0x0100,
    Using = 0x0200,
    Pocket = 0x0400,
    Handbag = 0x0800,
    TrousersFrontPocket = 0x1000,
    TrousersBackPocket = 0x1100
};