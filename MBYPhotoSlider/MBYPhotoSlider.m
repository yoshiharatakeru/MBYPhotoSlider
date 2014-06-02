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
UIScrollViewDelegate>
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
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_collectionView];
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [self setBtnClose];
}


#pragma mark -
#pragma mark collectionView

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
    MBYPinchImageView *pinchView = (MBYPinchImageView *)[cell viewWithTag:1];
    pinchView.image = self.photos[indexPath.row];
    
    //開いて直後の1枚はalphaが1.0
    cell.contentView.alpha = (_didShowFirstImage)? 0:1.0;
    
    _didShowFirstImage = YES;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in _collectionView.visibleCells) {
        [UIView animateWithDuration:0.1 animations:^{
            cell.contentView.alpha = 1.0;
        }];
    }
}


#pragma mark -
#pragma mark plivate mehtods

- (void)setBtnClose
{
    UIButton *btnClose = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnClose.frame = CGRectMake(30, 30, 100, 30);
    [btnClose setTitle:@"Close" forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(btnClosePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnClose];
}


- (void)btnClosePressed:(UIButton*)sender
{
    [self.view removeFromSuperview];
}


- (void)close
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
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
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}



@end
