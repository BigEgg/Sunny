//
//  RecordDetailViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 7/24/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "RecordDetailViewController.h"

@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)phoneTypeMovingChanged:(id)sender {
}

- (IBAction)phoneTypeSideChanged:(id)sender {
}
- (IBAction)phoneStatusChanged:(id)sender {
}

- (IBAction)stopRecord:(id)sender {
}

- (IBAction)startRecord:(id)sender {
}

- (IBAction)cancelRecord:(id)sender {
}
@end
