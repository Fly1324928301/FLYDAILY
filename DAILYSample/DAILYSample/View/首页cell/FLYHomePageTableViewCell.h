//
//  FLYHomePageTableViewCell.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-23.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYNews.h"
@interface FLYHomePageTableViewCell : UITableViewCell

// 设置显示内容
- (void)setcellInputViewDataAndFramWithNews:(FLYNews *)news;


// cell高度
+ (float)setCellHeigthWithNews:(FLYNews *)news;


@end
