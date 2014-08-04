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
    self.first_image = nil;
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


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.author forKey:@"author"];
    [aCoder encodeObject:self.classify forKey:@"classify"];
    [aCoder encodeObject:self.dateinfo forKey:@"dateinfo"];
    [aCoder encodeObject:self.first_image forKey:@"first_image"];
    [aCoder encodeObject:self.image_real_height forKey:@"image_real_height"];
    [aCoder encodeObject:self.image_real_width forKey:@"image_real_width"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeObject:self.linkid forKey:@"linkid"];
    [aCoder encodeObject:self.share_text forKey:@"share_text"];
    [aCoder encodeObject:self.share_url forKey:@"share_url"];
    [aCoder encodeObject:self.sortid forKey:@"sortid"];
    [aCoder encodeObject:self.tag forKey:@"tag"];
    [aCoder encodeObject:self.timeStamp forKey:@"timeStamp"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.url forKey:@"url"];
    
    
    
}





- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    
    if ([super init]) {
        
        self.author = [aDecoder decodeObjectForKey:@"author"];
        self.classify = [aDecoder decodeObjectForKey:@"classify"];
        self.dateinfo = [aDecoder decodeObjectForKey:@"dateinfo"];
        self.first_image = [aDecoder decodeObjectForKey:@"first_image"];
        self.image_real_height = [aDecoder decodeObjectForKey:@"image_real_height"];
        self.image_real_width = [aDecoder decodeObjectForKey:@"image_real_width"];
        self.info = [aDecoder decodeObjectForKey:@"info"];
        self.linkid = [aDecoder decodeObjectForKey:@"linkid"];
        self.share_text = [aDecoder decodeObjectForKey:@"share_text"];
        self.share_url = [aDecoder decodeObjectForKey:@"share_url"];
        self.sortid = [aDecoder decodeObjectForKey:@"sortid"];
        self.tag = [aDecoder decodeObjectForKey:@"tag"];
        self.timeStamp = [aDecoder decodeObjectForKey:@"timeStamp"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.url = [aDecoder decodeObjectForKey:@"url"];
        
        
    }
    return self;
}







- (id)valueForUndefinedKey:(NSString *)key
{
    
    return nil;
    
}


- (NSString *)description
{
    
    return [NSString stringWithFormat:@"author = %@,dateinfo = %@,image = %@,tag = %@,title = %@,url = %@",self.author,self.dateinfo,self.first_image,self.tag,self.title,self.url];
    
}

@end
