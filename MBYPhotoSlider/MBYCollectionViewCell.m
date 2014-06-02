//
//  MBYCollectionViewCell.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/30.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYCollectionViewCell.h"
#import "MBYPinchImageView.h"
@interface MBYCollectionViewCell()
{
    MBYPinchImageView *_pinchView;
}
@end

@implementation MBYCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        //pinchView
        _pinchView = [[MBYPinchImageView alloc]initWithFrame:self.bounds];
        _pinchView.tag = 1;
        [self.contentView addSubview:_pinchView];
    }
    
    return self;
}


@end
