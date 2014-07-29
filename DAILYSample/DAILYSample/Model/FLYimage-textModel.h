//
//  FLYimage-textModel.h
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLYNews.h"
@interface FLYimage_textModel : NSObject

@property (nonatomic, strong) FLYNews *news;
@property (nonatomic, copy) NSString *first_image;
@property (nonatomic, copy) NSString *image_textID;
@property (nonatomic, copy) NSString *share_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;

@end
