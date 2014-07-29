//
//  FLYAdaptPicTableViewCell.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYNews.h"
@interface FLYAdaptPicTableViewCell : UITableViewCell

// 设置显示内容
- (void)setAdaptcellInputViewDataAndFramWithNews:(FLYNews *)news;

// cell高度
+ (float)setAdaptCellHeigthWithNews:(FLYNews *)news;

@end
