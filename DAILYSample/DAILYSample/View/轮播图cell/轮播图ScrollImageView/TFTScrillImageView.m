//
//  TFTScrillImageView.m
//  TFTDevelopmentKit
//
//  Created by SongXiaobo on 14-5-27.
//  Copyright (c) 2014年 SongXiaobo. All rights reserved.
//

#import "TFTScrillImageView.h"

@implementation TFTScrillImageView {
    CGFloat width;  //  宽
    CGFloat height; //  高
    UIScrollView * scrollView;  //  滑动视图
    NSMutableArray * imageViewContainer;    //  图片视图容器
    NSMutableArray * imageContainer;    //  图片容器
    //  回调用 Blocks
    DidChangeImageBlocks didChangeImageBlock;
    DidTapImageBlocks didTapImageBlock;
    DidRefreshImages didrefreshImage;
}

#pragma mark - 初始化

//  初始化方法
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images {
    self = [super initWithFrame:frame];
    if(self) {
        imageContainer = [NSMutableArray arrayWithArray:images];
        [self loadData];
        [self setupUI];
        
    }
    return self;
}

#pragma mark - 改变图片内容

//  重新加载图片
- (void)reloadImages:(NSArray *)images {
    [imageContainer removeAllObjects];
    [imageContainer addObjectsFromArray:images];
    _currentIndex = 0;
    _currentImageCount = imageContainer.count;
    [self refreshImage];
}

#pragma mark - 加载数据和界面

//  加载数据
- (void)loadData {
    width = self.frame.size.width;
    height = self.frame.size.height;
    _currentIndex = 0;
    _currentImageCount = imageContainer.count;
    imageViewContainer = [NSMutableArray arrayWithCapacity:1];
}

//  加载界面
- (void)setupUI {
    [self setupScrollView];
    [self setupImageViews];
    [self refreshImage];
}

//  加载滑动视图
- (void)setupScrollView {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(width * 3, height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
}

//  加载图片视图
- (void)setupImageViews {
    for(int i = 0;i < 3;i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        [scrollView addSubview:imageView];
        [imageViewContainer addObject:imageView];
    }
}

#pragma mark - 刷新视图

//  刷新图片
- (void)refreshImage {
    [self refreshCenterImage];
    [self moveToCenter];
    [self refreshOtherSideImage];
    if (didrefreshImage) {
        didrefreshImage(self.currentIndex);
    }
    
}

//  刷新中部图片
- (void)refreshCenterImage {
    UIImageView * centerImageView = [imageViewContainer objectAtIndex:1];
    centerImageView.image = [imageContainer objectAtIndex:self.currentIndex];
}

//  移动到中部
- (void)moveToCenter {
    scrollView.contentOffset = CGPointMake(width, 0);
}

//  刷新两边图片
- (void)refreshOtherSideImage {
    UIImageView * leftImageView = [imageViewContainer objectAtIndex:0];
    leftImageView.image = [imageContainer objectAtIndex:[self fixIndex:self.currentIndex - 1]];
    UIImageView * rightImageView = [imageViewContainer objectAtIndex:2];
    rightImageView.image = [imageContainer objectAtIndex:[self fixIndex:self.currentIndex + 1]];
}

#pragma mark - 工具

//  修正下标
- (NSInteger)fixIndex:(NSInteger)index {
    NSInteger i = index;
    if(i < 0) {
        i = imageContainer.count + i;
    }else if(i > imageContainer.count - 1) {
        i = i - imageContainer.count;
    }
    return i;
}

//  刷新当前下标
- (void)refreshCurrentIndex {
    if(scrollView.contentOffset.x < width / 2) {
        _currentIndex = [self fixIndex:self.currentIndex - 1];
        if(didChangeImageBlock) {
            didChangeImageBlock(self.currentIndex);
        }
    }else if(scrollView.contentOffset.x > width / 2 * 3 && scrollView.contentOffset.x < width * 3) {
        _currentIndex = [self fixIndex:self.currentIndex + 1];
        if(didChangeImageBlock) {
            didChangeImageBlock(self.currentIndex);
        }
    }else {
        return;
    }
    [self refreshImage];
}

#pragma mark - 回调方法

//  回调方法 - 当前图片已被切换
- (void)didChangeImageUsingBlock:(DidChangeImageBlocks)didChangeImage {
    didChangeImageBlock = [didChangeImage copy];
}

//  回调方法 - 当前图片已被点击
- (void)didTapImageUsingBlock:(DidTapImageBlocks)didTapImage {
    didTapImageBlock = didTapImage;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImage)];
    [self addGestureRecognizer:tap];
}

//  图片被点击
- (void)didTapImage {
    if(didTapImageBlock) {
        didTapImageBlock(self.currentIndex);
    }
}


// 图片刷新
- (void)didRefreshImageBlocks:(DidRefreshImages)didrefreshIm
{
    
    didrefreshImage = [didrefreshIm copy];
    
}


#pragma mark - 实现 UIScrollViewDelegate 方法

//  代理方法 - 拖拽已结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate) {
        [self refreshCurrentIndex];
    }
}

//  代理方法 - 减速已结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self refreshCurrentIndex];
}



- (void)replaceImage:(UIImage *)image atIndex:(NSInteger)index
{
    
    if (index < imageContainer.count) {
        
        [imageContainer replaceObjectAtIndex:index withObject:image];
        [self refreshImage];
        
    }
    
}


@end
