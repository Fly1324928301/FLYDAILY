//
//  FLYAnasilyWebViewDate.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-25.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYAnasilyWebViewDate.h"
#import "RegexKitLite.h"
#import "SDWebImageManager.h"
#import "FLYPicStoryPicModel.h"
#import "AFNetworking.h"
@interface FLYAnasilyWebViewDate ()



@end

@implementation FLYAnasilyWebViewDate
static FLYAnasilyWebViewDate *anasilyWebViewData = nil;
+ (instancetype)shareAnasilyWebViewData
{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        if (anasilyWebViewData == nil) {
            anasilyWebViewData = [[FLYAnasilyWebViewDate alloc] init];
        }
    });
    return anasilyWebViewData;
}





// 通过Url加载WebView
- (void)loadWebViewWithUrlStr:(NSString *)urlStr sucess:(RequestWebViewBlocks)sucess failed:(FailedWebViewBlocks)failed
{
    
    RequestWebViewBlocks requestWebViewBlock = [sucess copy];
    FailedWebViewBlocks failedWebViewBlock = [failed copy];
    
    __weak id selfTemp = self;
    
 
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            if (connectionError != nil) {
                failedWebViewBlock(connectionError);
                return ;
            }
            
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *htmlWeb = [selfTemp p_anasilyHtmlWithResponseObjcet:str];
            dispatch_async(dispatch_get_main_queue(), ^{
        requestWebViewBlock(htmlWeb);
            });
        });
        
        
    }];

    

}


// 通过解析网页获取图片数组
- (void)loadExhibitPicArryWithHtmlStr:(NSString *)htmlStr sucess:(RequestExhibitPicBlcoks)sucess failed:(FailedExhibitPicBlcoks)failed
{
//    <p class="image_with_info"><img src="http://www.bundpic.com/upload/images/149/336f0ccd9b50b16be29e93ad616905e8.jpg" alt="" /></p>
    
    NSString *regex = @"<img src=\"([a-zA-z]+://[^\\s]*)\" alt=\"\" /></p>";
    NSArray *urlArry = [htmlStr componentsMatchedByRegex:regex capture:1];
    
    RequestExhibitPicBlcoks requestExhibitPicBlock = [sucess copy];
    FailedExhibitPicBlcoks failedExhibitPicBlcok = [failed copy];
    if (urlArry != nil) {
        if (requestExhibitPicBlock) {
            
            __block NSArray *arry;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                arry = [self p_downloadIMGArryWithImgUrlArry:urlArry];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    requestExhibitPicBlock(arry);
                });
            });

        }
    }
    if (urlArry == nil) {
        if (failedExhibitPicBlcok) {
            failedExhibitPicBlcok(@"error");
        }
    }
}

// 点击图片故事获取图片故事内容
- (void)loadPicStoryTHArryWithUrlStr:(NSString *)urlStr sucess:(RequestPicStoryTHBlocks)sucess failed:(FailedPicStoryTHBlocks)failed
{
    
    RequestPicStoryTHBlocks requestPicStoryTHBlock = [sucess copy];
    FailedPicStoryTHBlocks failedPicStoryTHBlock = [failed copy];

    __weak id selfTemp = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (requestPicStoryTHBlock) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                NSArray *arryTemp = [selfTemp p_anasilyArryOfResponseObjcet:responseObject];
                NSArray *picArry = [selfTemp p_downloadIMGArryWithpicModelArry:arryTemp];
                NSDictionary *picStoryTHDic = @{@"imageArry": picArry,@"modelArry":arryTemp};
                dispatch_async(dispatch_get_main_queue(), ^{
                    requestPicStoryTHBlock(picStoryTHDic);
                });
                
            });
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedPicStoryTHBlock) {
            failedPicStoryTHBlock(error);
        }
        
    }];
    
    
    
}



#pragma mark -- private Methods
// 去除webView中的无用信息
- (NSString *)p_anasilyHtmlWithResponseObjcet:(NSString *)responseStr
{
    NSString *htmlTemp = responseStr;
    NSString *regex = @">(<img src=\"[a-zA-z]+://[^\\s]*\" alt=\"\" /></p></div>)[\\s]+<div id=\"end\"";
    NSString *fullIMG = [responseStr stringByMatching:regex capture:1];
    if (fullIMG) {
        
            htmlTemp = [htmlTemp stringByReplacingOccurrencesOfString:fullIMG withString:@""];
        
        
    }
    
    regex = @"(<div id=\"end\"[\\s\\S]+)<input type=\"hidden\"";
    NSString * str = [htmlTemp stringByMatching:regex capture:1];
    if (str) {
        htmlTemp = [htmlTemp stringByReplacingOccurrencesOfString:str withString:@"</div></div>"];
    }
    
    return htmlTemp;
}


// 获取webView中的图片数组
- (NSArray *)p_downloadIMGArryWithImgUrlArry:(NSArray *)urlArry
{
    NSMutableArray *imageArry = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSString *objUrl in urlArry) {
        NSURL *url = [NSURL URLWithString:objUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        if(image != nil){
        [imageArry addObject:image];
            
        }
    }
    
    return imageArry;
    
}


// 获取图片故事中的图片地址数组
- (NSArray *)p_anasilyArryOfResponseObjcet:(id)responseObjcet
{
    
    NSArray *listArry = (NSArray *)responseObjcet;
    NSMutableArray *picModelArry = [[NSMutableArray alloc] initWithCapacity:3];
    for (NSDictionary *imgDic in listArry) {
        FLYPicStoryPicModel *picStory = [[FLYPicStoryPicModel alloc] init];
        picStory.breif = imgDic[@"breif"];
        picStory.height = imgDic[@"height"];
        picStory.image_url = imgDic[@"image_url"];
        picStory.share_url = imgDic[@"share_url"];
        picStory.large_url = imgDic[@"large_url"];
        picStory.title = imgDic[@"title"];
        picStory.width = imgDic[@"width"];
        
        [picModelArry addObject:picStory];
        
    }
    
    return picModelArry;
    
    
}

// 获取图文故事点击详细中的图片数组
- (NSArray *)p_downloadIMGArryWithpicModelArry:(NSArray *)picModelArry
{
    NSMutableArray *urlArry = [NSMutableArray array];
    for (FLYPicStoryPicModel *PicModel in picModelArry) {
        [urlArry addObject:PicModel.image_url];
    }
    NSMutableArray *imageArry = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSString *objUrl in urlArry) {
        NSURL *url = [NSURL URLWithString:objUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc] initWithData:data];
        if (image != nil) {
        [imageArry addObject:image];
        }
        
    }
    
    return imageArry;
    
}





@end
