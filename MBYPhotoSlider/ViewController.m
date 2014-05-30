//
//  ViewController.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "ViewController.h"
#import "MBYPhotoSlider.h"
#import "MBYPinchImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    
    [slider openWithIndex:2];
}



@end
