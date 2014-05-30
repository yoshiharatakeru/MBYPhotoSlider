//
//  MBYPhotoSlider.h
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBYPhotoSliderDelegate;

@interface MBYPhotoSlider : UIViewController

@property (nonatomic, weak) id delegate;

- (id)initWithPhotos:(NSArray*)photos;
- (void)openWithIndex:(NSInteger)index;

@end


@protocol MBYPhotoSliderDelegate <NSObject>


@end