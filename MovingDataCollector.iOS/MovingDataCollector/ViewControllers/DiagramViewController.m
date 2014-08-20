//
//  DiagramViewController.m
//  MovingDataCollector
//
//  Created by Jianming Xiao on 8/9/14.
//  Copyright (c) 2014 jianming.xiao. All rights reserved.
//

#import "DiagramViewController.h"

@interface DiagramViewController ()

@end

@implementation DiagramViewController

#pragma mark - View LifeCycle

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
    
    [self.sectionView addSubview:self.cosView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sections

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.cosView];
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Section View Segment is invalid, index: %ld", (long) sectionControl.selectedSegmentIndex];
    }
}

#pragma mark - COS View


@end
