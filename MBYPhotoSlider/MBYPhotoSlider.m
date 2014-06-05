//
//  MBYPhotoSlider.m
//  MBYPhotoSlider
//
//  Created by Takeru Yoshihara on 2014/05/27.
//  Copyright (c) 2014年 Takeru Yoshihara. All rights reserved.
//

#import "MBYPhotoSlider.h"
#import "MBYPinchImageView.h"
#import "MBYCollectionViewCell.h"

@interface MBYPhotoSlider ()
<UICollectionViewDataSource, UICollectionViewDelegate,
UIScrollViewDelegate, MBYPinchImageViewDelegate>
{
    UICollectionView *_collectionView;
    BOOL _didShowFirstImage;
}

@end

@implementation MBYPhotoSlider

- (id)initWithPhotos:(NSArray*)photos
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _didShowFirstImage = NO;
    self.view.frame = [[UIScreen mainScreen]bounds];
    self.photos = photos;
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setPagingSign];
    [self setCloseButton];
    [self setCollectionView];

    return self;
}


#pragma mark -
#pragma mark collectionView

- (void)setCollectionView
{
    //collectionViewLayout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    //collectionView
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[MBYCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_collectionView];
    
    //collectionViewをautolayoutで常に下辺から52pxに設定
    [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(_collectionView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]-52-|" options:0 metrics:nil views:viewsDic]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_collectionView]|" options:0 metrics:nil views:viewsDic]];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}


- (MBYCollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdeintifier = @"cell";
    MBYCollectionViewCell  *cell;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdeintifier forIndexPath:indexPath];
    
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)updateCell:(MBYCollectionViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    //pinch view
    MBYPinchImageView *pinchView = (MBYPinchImageView *)[cell viewWithTag:1];
    pinchView.image = self.photos[indexPath.row];
    pinchView.delegate = self;
    
    //開いて直後の1枚はalphaが1.0
    cell.contentView.alpha = (_didShowFirstImage)? 1:0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updatePagingSignWithIndex:self.centerIndex+1 inNumberOfPhotos:self.photos.count];
    
    if([self.delegate respondsToSelector:@selector(photoSlider:didScrollToIndex:)]){
       [self.delegate photoSlider:self didScrollToIndex:self.centerIndex];
    }
}


#pragma mark -
#pragma mark plivate mehtods

- (void)close
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)setCloseButton
{
    UIButton *btn_close = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_close.frame = self.view.bounds;
    [btn_close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_close];
}


- (void)setPagingSign
{
    //ページ表記の○の追加
    UIImageView *iv_pagingSign = [UIImageView new];
    [iv_pagingSign setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:iv_pagingSign];
    
    //autolayout
    NSDictionary *viewsDic = NSDictionaryOfVariableBindings(iv_pagingSign);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-134-[iv_pagingSign]-134-|" options:0 metrics:nil views:viewsDic]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=20)-[iv_pagingSign(12)]-20-|" options:0 metrics:nil views:viewsDic]];
}


- (void)updatePagingSignWithIndex:(NSInteger)index inNumberOfPhotos:(NSInteger)num
{
    //選択された画像に従ってページサインの画像を準備
    NSString *name = [NSString stringWithFormat:@"slider_%d_%d_w", num, index];
    UIImage  *img_page = [UIImage imageNamed:name];
    
    for (UIImageView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            subView.image = img_page;
        }
    }
}


#pragma mark -
#pragma mark public methods

- (void)openWithIndex:(NSInteger)index
{
    UIViewController *parent = (UIViewController*)self.delegate;
    
    self.view.frame = [[UIScreen mainScreen]bounds];
    [parent addChildViewController:self];
    [parent.view addSubview:self.view];
    [self didMoveToParentViewController:self.delegate];
    
    //指定した番号の写真までスクロール
    [self performSelector:@selector(scrollToIndex:) withObject:[NSNumber numberWithInteger:index] afterDelay:0];
}


- (void)scrollToIndex:(NSNumber*)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index.intValue inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    [self updatePagingSignWithIndex:self.centerIndex+1 inNumberOfPhotos:self.photos.count];
    
    _didShowFirstImage = YES;
    
    //フェードインで表示
    for (UICollectionViewCell *cell in _collectionView.visibleCells) {
        [UIView animateWithDuration:0.1 animations:^{
            cell.contentView.alpha = 1.0;
        }];
    }
}


- (NSInteger)centerIndex
{
    CGPoint offset = [_collectionView contentOffset];
    return offset.x/_collectionView.bounds.size.width;
}


- (void)setBackGroudColor:(UIColor *)color
{
    [self.view setBackgroundColor:color];
}


- (void)setActiveArea:(CGRect)rect
{
    _collectionView.frame = rect;
}


#pragma mark -
#pragma mark pinchView

- (void)PinchImageViewDidTapOutsidePhoto
{
    [self close];
}

@end
