//
//  FLYNews.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-22.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYNews.h"

@implementation FLYNews

- (void)dealloc
{
    
    self.author = nil;
    self.classify = nil;
    self.dateinfo = nil;
    self.image = nil;
    self.image_real_height = nil;
    self.image_real_width = nil;
    self.info = nil;
    self.linkid = nil;
    self.share_text = nil;
    self.share_url = nil;
    self.sortid = nil;
    self.tag = nil;
    self.timeStamp = nil;
    self.title = nil;
    self.url = nil;
    
}

- (NSString *)description
{
    
    return [NSString stringWithFormat:@"author = %@,dateinfo = %@,image = %@,tag = %@,title = %@,url = %@",self.author,self.dateinfo,self.image,self.tag,self.title,self.url];
    
}

@end
