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

#define COS_DRAW_VIEW_WIDTH 212
#define COS_DRAW_VIEW_HEIGHT 169

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
    COSDrawView *cosDrawView = [[COSDrawView alloc] initWithHeight:COS_DRAW_VIEW_HEIGHT Width:COS_DRAW_VIEW_WIDTH];
    [self.cosDrawView addSubview:cosDrawView];
    drawView = cosDrawView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sections

- (IBAction)sectionChanged:(id)sender {
    UISegmentedControl *sectionControl = (UISegmentedControl *) sender;
    
    id<IDrawView> theDrawView = nil;
    
    switch (sectionControl.selectedSegmentIndex) {
        case 0:
            [self.sectionView addSubview:self.cosView];
            theDrawView = [[COSDrawView alloc] initWithHeight:COS_DRAW_VIEW_HEIGHT Width:COS_DRAW_VIEW_WIDTH];
            break;
        default:
            [NSException raise:@"Invalid Segment Selection"
                        format:@"Section View Segment is invalid, index: %ld", (long) sectionControl.selectedSegmentIndex];
    }
    
    [self.cosDrawView addSubview:(UIView *)theDrawView];
    drawView = theDrawView;
}

#pragma mark - Sensor Data Handlers

- (void)accelerometerHandler:(AccelerometerData *)data {
    [self cosViewAccelerometerHandler:data];
}


- (void)gyroscopeHandler:(GyroscopeData *)data {
    [self cosViewGyroscopeHandler:data];
}

#pragma mark - COS View
- (void)cosViewAccelerometerHandler:(AccelerometerData *)data {
    if (drawView) {
        [drawView drawAccelerometerData:data];
    }
}

- (void)cosViewGyroscopeHandler:(GyroscopeData *)data {
    if (drawView) {
        [drawView drawGyroscopeData:data];
    }
}

@end
