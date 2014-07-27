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
}

@property DataPackage *accelerometerDataPackage;
@property DataPackage *gyroscopeDataPackage;

@property NSString *fileName;

@property bool isStartRecord;
@property bool isSentRecord;

@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneMovingSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneSideSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phonePositionSegment;

@property(strong, nonatomic) IBOutlet UILabel *recordTimeLable;

@property(strong, nonatomic) IBOutlet UIButton *stopButton;
@property(strong, nonatomic) IBOutlet UIButton *startButton;
@property(strong, nonatomic) IBOutlet UIButton *cancelButton;
@property(strong, nonatomic) IBOutlet UIButton *sendButton;


- (IBAction)phoneStatusChanged:(id)sender;

- (IBAction)stopRecord:(id)sender;

- (IBAction)startRecord:(id)sender;

- (IBAction)cancelRecord:(id)sender;

- (IBAction)sendRecord:(id)sender;

@end
