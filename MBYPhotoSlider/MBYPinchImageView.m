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
    UIImageView *_imageView;
    UIScrollView *_scrollView;
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
        _imageView = [[UIImageView alloc]initWithFrame:_scrollView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_scrollView addSubview:_imageView];
        [self addSubview:_scrollView];
    }
    return self;
}


- (void)setImage:(UIImage *)image
{
    _scrollView.zoomScale = 1.0;
    
    
    _imageView.image = image;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}


@end
