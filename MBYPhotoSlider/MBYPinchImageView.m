//
//  MBYPinchImageView.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/30.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYPinchImageView.h"

@interface MBYPinchImageView()
<UIScrollViewDelegate>
{
    UIImageView  *_imageView;
    UIScrollView *_scrollView;
    BOOL          _didDoubleTapped;
}
@end

@implementation MBYPinchImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //scrollViewの配置
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 3.0;
        _scrollView.delegate  = self;
        
        //imageViewの配置
        _imageView = [UIImageView new];
        [self addSubview:_scrollView];

        //ダブルタップ
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [tapGes setNumberOfTapsRequired:2];
        [_scrollView addGestureRecognizer:tapGes];
        
        [_scrollView addSubview:_imageView];
    }
    return self;
}


- (void)setImage:(UIImage *)image
{
    _scrollView.zoomScale = 1.0;
    _imageView.image = image;
    [self updateImageViewSize];
    [self updateImageViewOrigin];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [UIView animateWithDuration:0.2 animations:^{
        [self updateImageViewOrigin];
    }];
}


- (void)tapAction:(UITapGestureRecognizer*)sender
{
    if (_didDoubleTapped) {//縮小
        [UIView animateWithDuration:0.2 animations:^{
            _scrollView.zoomScale = 1.0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.2 animations:^{
                [self updateImageViewOrigin];
            }];
        }];
        _didDoubleTapped = NO;
    
    }else{//拡大
        [UIView animateWithDuration:0.2 animations:^{
            _scrollView.zoomScale *= 2.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [self updateImageViewOrigin];
            }];
        }];
        _didDoubleTapped = YES;
    }
}


- (void)updateImageViewSize
{
    // Get image size
    CGSize  imageSize;
    imageSize = _imageView.image.size;
    
    // Decide image view size
    CGRect  bounds;
    CGRect  rect;
    bounds = _scrollView.bounds;
    rect.origin = CGPointZero;
    if (imageSize.width / imageSize.height > CGRectGetWidth(bounds) / CGRectGetHeight(bounds)) {
        rect.size.width = CGRectGetWidth(bounds);
        rect.size.height = floor(imageSize.height / imageSize.width * CGRectGetWidth(rect));
    }
    else {
        rect.size.height = CGRectGetHeight(bounds);
        rect.size.width = imageSize.width / imageSize.height * CGRectGetHeight(rect);
    }
    
    // Set image view frame
    _imageView.frame = rect;
}


- (void)updateImageViewOrigin
{
    // Get image view frame
    CGRect  rect;
    rect = _imageView.frame;
    
    // Get scroll view bounds
    CGRect  bounds;
    bounds = _scrollView.bounds;
    
    // Compare image size and bounds
    rect.origin = CGPointZero;
    if (CGRectGetWidth(rect) < CGRectGetWidth(bounds)) {
        rect.origin.x = floor((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) * 0.5);
    }
    if (CGRectGetHeight(rect) < CGRectGetHeight(bounds)) {
        rect.origin.y = floor((CGRectGetHeight(bounds) - CGRectGetHeight(rect)) * 0.5);
    }
    
    // Set image view frame
    _imageView.frame = rect;
}

@end
