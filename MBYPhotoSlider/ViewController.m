//
//  ViewController.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "ViewController.h"
#import "MBYPhotoSlider.h"

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
    UIImage *photo_1 = [UIImage imageNamed:@"happy_200"];
    UIImage *photo_2 = [UIImage imageNamed:@"frog"];
    
    NSArray *photos = @[photo_0,photo_1,photo_2,photo_1];
    
    MBYPhotoSlider *slider = [[MBYPhotoSlider alloc]initWithPhotos:photos];
    slider.delegate = self;
    
    [slider openWithIndex:2];
}


- (void)photoSlider:(id)sender didScrollToIndex:(NSInteger)index
{
    NSLog(@"center_index:%d", index);
}


@end
