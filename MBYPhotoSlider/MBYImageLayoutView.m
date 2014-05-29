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

- (id)initWithFrame:(CGRect)frame image:(UIImage*)image
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //imageの配置
        _imageView = [[MBYVariableSizedImageView alloc]initWithImage:image];
        _imageView.userInteractionEnabled = YES;
        
        //pan gesture
        UIPanGestureRecognizer *panGesture;
        panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        [_imageView addGestureRecognizer:panGesture];
        
        //first position
        [self applyImageViewToBaseView];
        [self addSubview:_imageView];
    }
    return self;
}

#pragma mark -
#pragma mark private methods

- (void)panAction:(UIPanGestureRecognizer*)sender
{
    //move
    CGPoint movedPoint = [sender translationInView:self];
    
    _imageView.center = CGPointMake(_imageView.center.x + movedPoint.x, _imageView.center.y + movedPoint.y);
    
    [sender setTranslation:CGPointZero inView:self];
    
}

//画像をviewの中心に収める
- (void)applyImageViewToBaseView
{
    UIImage *image = _imageView.image;
    
    if (image.size.width > image.size.height) {//横長
        _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width * image.size.height/image.size.width);
    
    }else{//縦長 or 正方形
        _imageView.frame = CGRectMake(0, 0, self.bounds.size.height * image.size.width/image.size.height, self.bounds.size.height);
    }
    
    _imageView.center = self.center ;
}



#pragma mark -
#pragma mark public methods


@end
