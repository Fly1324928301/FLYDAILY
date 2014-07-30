//
//  FLYNetWorkingManage.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-22.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义Blocks - 首页
typedef void (^RequestHomePageListBlocks)(NSDictionary *dictionary);
typedef void (^FailedHomePageListBlocks)(NSError *error);

// 热门
typedef void (^RequestHotPageListBlocks)(NSArray *array);
typedef void(^FailedHotPageListBlocks)(NSError *error);


// 每日精选
typedef void(^RequestHandPickPageListBlocks)(NSArray *array);
typedef void(^FailedHandPickPageListBlocks)(NSError *error);

// 图片故事
typedef void(^RequestImage_textPageListBlocks)(NSArray *array);
typedef void(^FailedImage_textPageListBlocks)(NSError *error);


// 本周推荐
typedef void(^RequestWeekPageListBlocks)(NSArray *array);
typedef void(^FailedWeekPageListBlocks)(NSError *error);


// 新闻/文艺/时尚/生活
typedef void(^RequestLifePageListBlocks)(NSArray *array);
typedef void(^FailedLifePageListBlocks)(NSError *error);

@interface FLYNetWorkingManage : NSObject

// 获取单例方法
+ (instancetype)currentNetWorkManager;

// 获取首页数据
- (void)requestHomePageListWithCompletion:(RequestHomePageListBlocks)homecompletion error:(FailedHomePageListBlocks)error;
// 刷新首页数据
- (void)refreshHomePageListWithCompletion:(RequestHomePageListBlocks)homecompletion error:(FailedHomePageListBlocks)error;


// 获取热门数据
- (void)requestHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error;
// 刷新热门数据
- (void)refreshHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error;
// 加载更多热门数据
- (void)loadMoreHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error;


// 获取每日精选数据
- (void)requestHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error;
// 刷新每日精选数据
- (void)refreshHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error;
// 加载更多每日精选数据
- (void)loadMoreHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error;


// 获取图片故事数据
- (void)requestImage_textPageListWithCompletion:(RequestImage_textPageListBlocks)completion error:(FailedImage_textPageListBlocks)error;


// 获取本周推荐数据
- (void)requestWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error;
// 刷新本周推荐数据
- (void)refreshWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error;
// 加载更多本周推荐数据
- (void)loadMoreWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error;


// 获取新闻/文艺/时尚/生活数据
- (void)requestLifePageListWithType:(NSString *)type Completion:(RequestLifePageListBlocks)completion error:(FailedLifePageListBlocks)error;
// 获取更多新闻/文艺/时尚/生活数据
- (void)lodeMoreLifePageListWithType:(NSString *)type Completion:(RequestLifePageListBlocks)completion error:(FailedLifePageListBlocks)error;


@end
