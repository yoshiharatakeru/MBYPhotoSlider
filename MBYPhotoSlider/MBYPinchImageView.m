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
@end

@implementation MBYPinchImageView

- (id)initWithImage:(UIImage*)image frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //scrollViewの配置
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        scrollView.minimumZoomScale = 1.0;
        scrollView.maximumZoomScale = 3.0;
        scrollView.delegate  = self;
        
        //imageViewの配置
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:scrollView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        
        [scrollView addSubview:imageView];
        [self addSubview:scrollView];
    }
    return self;
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0];
}


@end
