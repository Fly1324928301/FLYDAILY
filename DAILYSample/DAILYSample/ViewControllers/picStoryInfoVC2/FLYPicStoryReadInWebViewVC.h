//
//  FLYPicStoryReadInWebViewVC.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYNews.h"
@interface FLYPicStoryReadInWebViewVC : UIViewController <UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)NSString *newsUrlStr;

@end
