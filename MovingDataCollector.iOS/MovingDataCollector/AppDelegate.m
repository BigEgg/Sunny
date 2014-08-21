//
//  AppDelegate.m
//  MovingDataCollector
//
//  Created by jianming.xiao on 6/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "AppDelegate.h"
#import "SensorDataViewController.h"
#import "RecordViewController.h"
#import "DiagramViewController.h"

@implementation AppDelegate

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor orangeColor];

    SensorDataViewController *sensorDataVC = [[SensorDataViewController alloc] initWithNibName:@"SensorDataViewController" bundle:nil];
    sensorDataVC.title = @"Sensor Data";
    RecordViewController *recordVC = [[RecordViewController alloc] initWithNibName:@"RecordViewController" bundle:nil];
    recordVC.title = @"Record Data";
    DiagramViewController *diagramVC = [[DiagramViewController alloc] initWithNibName:@"DiagramViewController" bundle:nil];
    diagramVC.title = @"Sensor Diagram";

    [self initMotionServiceWithSensorDataVC:sensorDataVC RecordVC:recordVC DiagramVC:diagramVC];

    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:sensorDataVC, recordVC, diagramVC, nil];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    [motionService initializeMotionManager];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Private Methods

- (void)initMotionServiceWithSensorDataVC:(SensorDataViewController *)sensorDataViewController
                                 RecordVC:(RecordViewController *)recordViewController
                                DiagramVC:(DiagramViewController *)diagramViewController {
    motionService = [[MotionService alloc] init];
    [motionService addHandler:(id <ISensorDataHandler>) sensorDataViewController];
    [motionService addHandler:(id <ISensorDataHandler>) recordViewController];
    [motionService addHandler:(id <ISensorDataHandler>) diagramViewController];
}
@end
