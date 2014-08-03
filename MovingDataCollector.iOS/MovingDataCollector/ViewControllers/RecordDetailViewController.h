//
//  RecordDetailViewController.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataPackage.h"

@interface RecordDetailViewController : UIViewController {
    DataPackage *accelerometerDataPackage;
    DataPackage *gyroscopeDataPackage;
}

@property bool isStartRecord;
@property bool canEdit;

@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneMovingSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneSideSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phonePositionSegment;

@property(strong, nonatomic) IBOutlet UILabel *recordTimeLable;

- (IBAction)phoneStatusChanged:(id)sender;

- (IBAction)stopRecord:(id)sender;

- (IBAction)startRecord:(id)sender;

- (IBAction)cancelRecord:(id)sender;

@end