//
//  RecordsTableViewController.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/23/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MotionService.h"

@interface RecordsTableViewController : UITableViewController

@property(strong, nonatomic) NSArray *tableViewData;
@property MotionService *motionService;

@end
