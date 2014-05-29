//
//  MBYImageLayoutView.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/28.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYImageLayoutView.h"
#import "MBYVariableSizedImageView.h"

@interface MBYImageLayoutView()
{
    MBYVariableSizedImageView *_imageView;
}

@end

@implementation MBYImageLayoutView

#pragma mark -
#pragma mark private methods

- (void)panAction:(UIPanGestureRecognizer*)sender
{
    //move
    CGPoint movedPoint = [sender translationInView:self];
    
    _imageView.center = CGPointMake(_imageView.center.x + movedPoint.x, _imageView.center.y + movedPoint.y);
    
    [sender setTranslation:CGPointZero inView:self];
}


//viewの中心frame
- (CGRect)centerFrameForImage:(UIImage*)image
{
    CGFloat w, h, x, y;

    if (image.size.width > image.size.height) {//横長
        w = self.bounds.size.width;
        h = self.bounds.size.width * image.size.height/image.size.width;
        x = 0;
        y = (self.bounds.size.height - h) / 2;
    
    }else{//縦長 or 正方形
        w = self.bounds.size.height * image.size.width/image.size.height;
        h = image.size.width/image.size.height;
        x = (self.bounds.size.width - w) / 2;
        y = 0;
    }
    return CGRectMake(x, y, w, h);
}


- (void)setImage:(UIImage *)image
{
    _imageView = [[MBYVariableSizedImageView alloc]initWithFrame:[self centerFrameForImage:image]];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = image;
    
    //pan gesture
    UIPanGestureRecognizer *panGesture;
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [_imageView addGestureRecognizer:panGesture];
    
    [self addSubview:_imageView];
}


#pragma mark -
#pragma mark public methods


@end
