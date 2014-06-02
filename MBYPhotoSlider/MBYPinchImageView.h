//
//  MBYPinchImageView.h
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/30.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MBYPinchImageViewDelegate;

@interface MBYPinchImageView : UIView

@property (nonatomic,strong) UIImage *image;
@property (nonatomic, weak) id delegate;

- (id)initWithFrame:(CGRect)frame;

@end


@protocol MBYPinchImageViewDelegate <NSObject>

- (void)PinchImageViewDidTapOutsidePhoto;

@end
