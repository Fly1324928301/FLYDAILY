//
//  FLYPicStory2ViewController.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLYimage-textModel.h"
@interface FLYPicStory2ViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>


@property (nonatomic, strong) FLYimage_textModel *img_txtModel;

@end
