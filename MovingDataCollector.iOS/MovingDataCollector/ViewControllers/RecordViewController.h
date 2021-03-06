//
//  RecordDetailViewController.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataPackage.h"
#import "ISensorDataHandler.h"
#import "IDrawView.h"

@interface RecordViewController : UIViewController <ISensorDataHandler> {
    bool isInit;
    int recordCount;
    bool isStartRecord;

    DataPackage *accelerometerDataPackage;
    DataPackage *gyroscopeDataPackage;
    
    id<IDrawView> drawView;
}

@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneMovingSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phoneSideSegment;
@property(strong, nonatomic) IBOutlet UISegmentedControl *phonePositionSegment;

@property(strong, nonatomic) IBOutlet UIButton *stopButton;
@property(strong, nonatomic) IBOutlet UIButton *startButton;
@property(strong, nonatomic) IBOutlet UIButton *cancelButton;
@property(strong, nonatomic) IBOutlet UIButton *sendButton;

@property(strong, nonatomic) IBOutlet UIView *sectionView;

@property(strong, nonatomic) IBOutlet UIView *recordInfoView;
@property(strong, nonatomic) IBOutlet UILabel *recordSecondsLable;
@property(strong, nonatomic) IBOutlet UITextView *noticeLable;


- (IBAction)phoneStatusChanged:(id)sender;

- (IBAction)stopRecord:(id)sender;

- (IBAction)startRecord:(id)sender;

- (IBAction)cancelRecord:(id)sender;

- (IBAction)sendRecord:(id)sender;

- (IBAction)sectionChanged:(id)sender;

@end
