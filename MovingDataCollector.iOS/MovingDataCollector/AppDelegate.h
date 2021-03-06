//
//  AppDelegate.h
//  MovingDataCollector
//
//  Created by jianming.xiao on 6/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MotionService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    MotionService *motionService;
}

@property(strong, nonatomic) UIWindow *window;
@property(nonatomic, retain) UITabBarController *tabBarController;

@end
