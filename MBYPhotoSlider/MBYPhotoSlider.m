//
//  MBYPhotoSlider.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYPhotoSlider.h"

@interface MBYPhotoSlider ()

@end

@implementation MBYPhotoSlider

- (id)initWithPhotos:(NSArray*)photos
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    //initialize
    self.view.backgroundColor = [UIColor redColor];
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    [self setBtnClose];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)didMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"didMoveToParentController");
}

#pragma mark -
#pragma mark plivate mehtods

- (void)setBtnClose
{
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnClose.frame = CGRectMake(30, 30, 100, 30);
    [btnClose setTitle:@"Close" forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(btnClosePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnClose];
}


- (void)btnClosePressed:(UIButton*)sender
{
    [self.view removeFromSuperview];
}


- (void)close
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


#pragma mark -
#pragma mark public methods

- (void)open
{
    UIViewController *parent = (UIViewController*)self.delegate;
    
    self.view.frame = [[UIScreen mainScreen]bounds];
    [parent addChildViewController:self];
    [parent.view addSubview:self.view];
    [self didMoveToParentViewController:self.delegate];
}




@end
