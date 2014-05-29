//
//  MBYVariableSizedImageView.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/28.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYVariableSizedImageView.h"
@interface MBYVariableSizedImageView()
<UIGestureRecognizerDelegate>
{
    float _scale;
    BOOL  _isMoving;
    CGAffineTransform _currentTransform;
}

@end


@implementation MBYVariableSizedImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self prepareGestureRecognizer];
    }
    return self;
}

#pragma mark -
#pragma mark private methods
- (void)prepareGestureRecognizer
{

    //拡大ジェスチャー
    UIPinchGestureRecognizer *pinch;
    pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    pinch.delegate = self;
    [self addGestureRecognizer:pinch];
    
    _isMoving = NO;
    _scale = 1.0f;
}

- (void)pinchAction:(UIPinchGestureRecognizer*)sender
{
    //開始時
    if(!_isMoving && sender.state == UIGestureRecognizerStateBegan)
    {
        _isMoving = YES;
        _currentTransform = self.transform;
    }
    
    //終了時
    else if(_isMoving == YES && sender.state == UIGestureRecognizerStateEnded){
        _isMoving = NO;
        _scale = 1.0f;
    }
    
    _scale = sender.scale;
    
    CGAffineTransform transform;
    transform = CGAffineTransformConcat(_currentTransform, CGAffineTransformMakeScale(_scale, _scale));
    
    sender.view.transform = transform;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


#pragma mark -
#pragma mark public methods


@end
