//
//  DiagramViewController.h
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiagramViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *sectionView;
@property (strong, nonatomic) IBOutlet UIView *cosView;

@property (strong, nonatomic) IBOutlet UIView *cosDrawView;

- (IBAction)sectionChanged:(id)sender;

@end
