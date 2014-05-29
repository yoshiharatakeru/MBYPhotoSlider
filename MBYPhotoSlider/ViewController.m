//
//  ViewController.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "ViewController.h"
#import "MBYPhotoSlider.h"
#import "MBYImageLayoutView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //layout検証
//    MBYImageLayoutView  *layoutView = [[MBYImageLayoutView alloc]initWithFrame:self.view.bounds image:[UIImage imageNamed:@"frog"]];
//    
//    [self.view addSubview:layoutView];
    
    MBYImageLayoutView *layoutView = [MBYImageLayoutView new];
    layoutView.frame = self.view.bounds;
    [self.view addSubview:layoutView];
    [layoutView setImage:[UIImage imageNamed:@"frog"]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) viewDidAppear:(BOOL)animated
{

}

#pragma mark -
#pragma mark button action

- (IBAction)btShowPhotosPressed:(id)sender {
    UIImage *photo_0 = [UIImage imageNamed:@"photo"];
    
    NSArray *photos = @[photo_0];
    
    MBYPhotoSlider *slider = [[MBYPhotoSlider alloc]initWithPhotos:photos];
    slider.delegate = self;
    
    [slider open];
}



@end
