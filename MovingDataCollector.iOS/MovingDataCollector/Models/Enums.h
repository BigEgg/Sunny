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
    Gyrometer = 2
};

typedef NS_ENUM(NSUInteger, PhoneStatus) {
    Stop = 0x000,
    Shake = 0x001,
    Run = 0x010,
    Walk = 0x011,

    Left = 0x0000,
    Right = 0x1000,

    Handheld = 0x00000000,
    HandheldUsing = 0x00010000,
    BackPocket = 0x00100000,
    Handbag = 0x00110000,
    TrousersFrontPocket = 0x01000000,
    TrousersBackPocket = 0x01010000
};