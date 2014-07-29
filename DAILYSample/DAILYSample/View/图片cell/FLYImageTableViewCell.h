//
//  FLYImageTableViewCell.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYimage-textModel.h"

@interface FLYImageTableViewCell : UITableViewCell

// 设置显示内容
- (void)setcellInputViewDataAndFramWithFLYimage_textModel:(FLYimage_textModel *)imageModel;


@end
