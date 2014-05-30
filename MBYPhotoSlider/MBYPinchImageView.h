//
//  MBYPinchImageView.h
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/30.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBYPinchImageView : UIView

@property (nonatomic,strong) UIImage *image;

- (id)initWithImage:(UIImage*)image frame:(CGRect)frame;

@end
