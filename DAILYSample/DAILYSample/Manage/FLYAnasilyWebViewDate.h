//
//  FLYAnasilyWebViewDate.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-25.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <Foundation/Foundation.h>
// webView
typedef void(^RequestWebViewBlocks)(NSString *htmlStr);
typedef void(^FailedWebViewBlocks)(NSError *error);

// ExhibitPicCell
typedef void(^RequestExhibitPicBlcoks)(NSArray *picArry);
typedef void(^FailedExhibitPicBlcoks)(NSString *error);

// 图片故事
typedef void(^RequestPicStoryTHBlocks)(NSDictionary *picdataDic);
typedef void(^FailedPicStoryTHBlocks)(NSError *error);

@interface FLYAnasilyWebViewDate : NSObject

+ (instancetype)shareAnasilyWebViewData;

// 通过Url加载WebView
- (void)loadWebViewWithUrlStr:(NSString *)urlStr sucess:(RequestWebViewBlocks)sucess failed:(FailedWebViewBlocks)failed;

// 通过解析网页获取图片数组
- (void)loadExhibitPicArryWithHtmlStr:(NSString *)htmlStr sucess:(RequestExhibitPicBlcoks)sucess failed:(FailedExhibitPicBlcoks)failed;

// 点击图片故事获取图片故事内容
- (void)loadPicStoryTHArryWithUrlStr:(NSString *)urlStr sucess:(RequestPicStoryTHBlocks)sucess failed:(FailedPicStoryTHBlocks)failed;

@end
