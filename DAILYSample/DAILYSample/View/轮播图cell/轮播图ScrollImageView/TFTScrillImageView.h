//
//  TFTScrillImageView.h
//  TFTDevelopmentKit
//
//  Created by SongXiaobo on 14-5-27.
//  Copyright (c) 2014年 SongXiaobo. All rights reserved.
//
//  轮播图 V1.0
//      -（由 SongXiaobo 更新于 14-5-27）
//      - 通过重用能够循环滑动图片
//      - 提供了两个回调方法，分别是图片切换时的回调和图片点击时的回调
//

#import <UIKit/UIKit.h>

//  回调用 Blocks
typedef void (^DidChangeImageBlocks)(NSInteger currentIndex);
typedef void (^DidTapImageBlocks)(NSInteger currentIndex);
typedef void (^DidRefreshImages)(NSInteger currentIndex);

@interface TFTScrillImageView : UIView <UIScrollViewDelegate>

//  当前图片下标 - 只读属性，当前正在显示的图片下标
@property (nonatomic, readonly) NSInteger currentIndex;

//  当前图片总数 - 只读属性，当前视图中的图片总数
@property (nonatomic, readonly) NSInteger currentImageCount;

#pragma mark - 初始化

//  初始化方法 - 参数 iamges 中存放 UIImage 对象
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

#pragma mark - 改变图片内容

//  重新加载图片 - 首先会清除之前所有 UIImage，然后将 images 中的 UIImage 添加进去显示
- (void)reloadImages:(NSArray *)images;

- (void)replaceImage:(UIImage *)image atIndex:(NSInteger)index;


//  刷新图片
- (void)refreshImage;

#pragma mark - 回调方法

//  回调方法 - 当前图片已被切换，用户左右滑动导致图片切换时会调用 Block
- (void)didChangeImageUsingBlock:(DidChangeImageBlocks)didChangeImage;

//  回调方法 - 当前图片已被点击，用户点击当前显示的图片时会调用 Block
- (void)didTapImageUsingBlock:(DidTapImageBlocks)didTapImage;

// 回掉方法 - 图片刷新时会回掉
- (void)didRefreshImageBlocks:(DidRefreshImages)didrefreshIm;

@end
