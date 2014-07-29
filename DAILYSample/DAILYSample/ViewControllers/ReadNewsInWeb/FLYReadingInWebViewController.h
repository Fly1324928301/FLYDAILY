//
//  FLYReadingInWebViewController.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-25.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYNews.h"
@interface FLYReadingInWebViewController : UIViewController <UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)FLYNews *news;



@end
