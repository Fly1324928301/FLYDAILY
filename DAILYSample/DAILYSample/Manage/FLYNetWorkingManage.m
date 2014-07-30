//
//  FLYNetWorkingManage.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-22.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYNetWorkingManage.h"
#import "FLYNews.h"
#import "FLYimage-textModel.h"

@interface FLYNetWorkingManage ()

{
    __block NSDictionary *_homePageDic;
    
    __block NSMutableArray *_hotPageArry;
    NSString *_hotPage;
    
    __block NSMutableArray *_handPickArry;
    NSString *_handPage;
    
    __block NSArray *_image_textArry;
    
    __block NSMutableArray *_weekArry;
    NSString *_weekPage;
    
    __block NSMutableArray *_lifeArry;
    NSString *_lifePage;
}



// 解析首页信息
- (NSDictionary *)p_analysisHomePageListOfdataDic:(id)dataDic;

@end

@implementation FLYNetWorkingManage

static FLYNetWorkingManage *netWork;





// 获取单例方法
+ (instancetype)currentNetWorkManager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[FLYNetWorkingManage alloc]init];
    });
    return netWork;
}


#pragma mark -- public methods
// 获取首页数据
- (void)requestHomePageListWithCompletion:(RequestHomePageListBlocks)homecompletion error:(FailedHomePageListBlocks)error
{
    
    RequestHomePageListBlocks requestHomePageListBlock = [homecompletion copy];
    FailedHomePageListBlocks failHomePageListBolck = [error copy];
    
    
    if (_homePageDic != nil && requestHomePageListBlock) {
        
        requestHomePageListBlock(_homePageDic);
        return;
    }
    __weak id selfTemp = self;
    
    static NSString *urlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=index";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHomePageListBlock) {
            
                NSDictionary *homeDic = [selfTemp p_analysisHomePageListOfdataDic:responseObject];
                _homePageDic = homeDic;
                requestHomePageListBlock(_homePageDic);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failHomePageListBolck) {
        failHomePageListBolck(error);
        }
    }];
    
    
    
}


// 刷新首页数据
- (void)refreshHomePageListWithCompletion:(RequestHomePageListBlocks)homecompletion error:(FailedHomePageListBlocks)error
{
    
    RequestHomePageListBlocks requestHomePageListBlock = [homecompletion copy];
    FailedHomePageListBlocks failHomePageListBolck = [error copy];
    
    
    __weak id selfTemp = self;
    
    static NSString *urlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=index";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHomePageListBlock) {
            
            NSDictionary *homeDic = [selfTemp p_analysisHomePageListOfdataDic:responseObject];
            _homePageDic = homeDic;
            requestHomePageListBlock(_homePageDic);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failHomePageListBolck) {
            failHomePageListBolck(error);
        }
    }];
    
}




// 获取热门数据
- (void)requestHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error
{
    
    RequestHotPageListBlocks requestHotPageListBlock = [hotcompletion copy];
    FailedHotPageListBlocks failedHotPageListBlock = [error copy];
    
    if (_hotPageArry != nil && requestHotPageListBlock) {
        requestHotPageListBlock (_hotPageArry);
        return;
    }
    _hotPage = @"2";
    __weak id selfTemp = self;
    _hotPageArry = [[NSMutableArray alloc] initWithCapacity:5];
    static NSString *urlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=hot";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHotPageListBlock) {
            NSArray *hotArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
            [_hotPageArry addObjectsFromArray: hotArry];
            requestHotPageListBlock(_hotPageArry);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHotPageListBlock) {
            failedHotPageListBlock(error);
        }
        
    }];
    

}
// 刷新热门数据
- (void)refreshHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error
{
    _hotPage = @"2";
    RequestHotPageListBlocks requestHotPageListBlock = [hotcompletion copy];
    FailedHotPageListBlocks failedHotPageListBlock = [error copy];
    
    if (_hotPageArry != nil) {
        _hotPageArry = nil;
    }
    _hotPageArry = [[NSMutableArray alloc] initWithCapacity:5];
    __weak id selfTemp = self;
    static NSString *urlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=hot";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHotPageListBlock) {
            NSArray *hotArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
            [_hotPageArry addObjectsFromArray: hotArry];
            requestHotPageListBlock(_hotPageArry);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHotPageListBlock) {
            failedHotPageListBlock(error);
        }
        
    }];
    
    
}

// 加载更多热门数据
- (void)loadMoreHotPageListWithCompletion:(RequestHotPageListBlocks)hotcompletion error:(FailedHotPageListBlocks)error
{
    RequestHotPageListBlocks requestHotPageListBlock = [hotcompletion copy];
    FailedHotPageListBlocks failedHotPageListBlock = [error copy];
    

    __weak id selfTemp = self;
    NSString *urlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=hot&pagenum=";
    urlStr = [urlStr stringByAppendingString:_hotPage];
    int pageTemp = [_hotPage intValue];
    _hotPage = [NSString stringWithFormat:@"%d",(pageTemp + 1)];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHotPageListBlock) {
            NSArray *hotArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
            [_hotPageArry addObjectsFromArray:hotArry];
            requestHotPageListBlock(_hotPageArry);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHotPageListBlock) {
            failedHotPageListBlock(error);
        }
        
    }];
    
}





// 获取每日精选数据
- (void)requestHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error
{
    
    RequestHandPickPageListBlocks requestHandPickPageListBlock = [handPickConpletion copy];
    FailedHandPickPageListBlocks failedHandPickPageListBlock = [error copy];
    
    if (_handPickArry != nil && requestHandPickPageListBlock) {
        requestHandPickPageListBlock(_handPickArry);
        return;
    }
    
    
    _handPage = @"2";
    _handPickArry = [[NSMutableArray alloc] initWithCapacity:5];
    
    __weak id selfTemp = self;
    static NSString *hpUrlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%AF%8F%E6%97%A5%E7%B2%BE%E9%80%89";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:hpUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHandPickPageListBlock) {
            NSArray *handPickArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
            [_handPickArry addObjectsFromArray: handPickArry];
            requestHandPickPageListBlock (_handPickArry);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHandPickPageListBlock) {
            
            failedHandPickPageListBlock (error);
            
        }
        
    }];
    
    
}



// 刷新每日精选数据
- (void)refreshHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error
{
    
    RequestHandPickPageListBlocks requestHandPickPageListBlock = [handPickConpletion copy];
    FailedHandPickPageListBlocks failedHandPickPageListBlock = [error copy];
    
    if (_handPickArry != nil ) {
        _handPickArry = nil;
    }
    
    
    _handPage = @"2";
    _handPickArry = [[NSMutableArray alloc] initWithCapacity:5];
    
    __weak id selfTemp = self;
    static NSString *hpUrlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%AF%8F%E6%97%A5%E7%B2%BE%E9%80%89";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:hpUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHandPickPageListBlock) {
            NSArray *handPickArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
            [_handPickArry addObjectsFromArray: handPickArry];
            requestHandPickPageListBlock (_handPickArry);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHandPickPageListBlock) {
            
            failedHandPickPageListBlock (error);
            
        }
        
    }];
    
    
}

// 加载更多每日精选数据
- (void)loadMoreHandPickPageListWithCompletion:(RequestHandPickPageListBlocks)handPickConpletion error:(FailedHandPickPageListBlocks)error
{
    
    RequestHandPickPageListBlocks requestHandPickPageListBlock = [handPickConpletion copy];
    FailedHandPickPageListBlocks failedHandPickPageListBlock = [error copy];
    
    
    
    
    
    __weak id selfTemp = self;
    NSString *hpUrlStr = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%AF%8F%E6%97%A5%E7%B2%BE%E9%80%89&pagenum=";
    hpUrlStr = [hpUrlStr stringByAppendingString:_handPage];
    int pageTemp = [_handPage intValue];
    _handPage = [NSString stringWithFormat:@"%d",(pageTemp + 1)];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:hpUrlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestHandPickPageListBlock) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSArray *handPickArry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
                [_handPickArry addObjectsFromArray: handPickArry];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    requestHandPickPageListBlock (_handPickArry);
                });
                
            });
           
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedHandPickPageListBlock) {
            
            failedHandPickPageListBlock (error);
            
        }
        
    }];
    
    
}




// 获取图片故事数据
- (void)requestImage_textPageListWithCompletion:(RequestImage_textPageListBlocks)completion error:(FailedImage_textPageListBlocks)error
{
    
    RequestImage_textPageListBlocks requestImage_textPageListBlock = [completion copy];
    FailedImage_textPageListBlocks failedImage_textPageListBlock = [error copy];
    if (_image_textArry != nil&&requestImage_textPageListBlock) {
        requestImage_textPageListBlock(_image_textArry);
        return;
    }
    __weak id selfTemp = self;
    static NSString *urlStr = @"http://www.bundpic.com/album_xml.php?perpage=50";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (requestImage_textPageListBlock) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSArray *arryTemp = [selfTemp p_anasysisImage_textWithResponseArry:responseObject];
                _image_textArry = arryTemp;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    requestImage_textPageListBlock(_image_textArry);
                });
                
            });
   
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failedImage_textPageListBlock) {
            failedImage_textPageListBlock(error);
        }
        
    }];
    
    
    
}



// 获取本周推荐数据
- (void)requestWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error
{
    
    RequestWeekPageListBlocks requestWeekPageListBlock = [completion copy];
    FailedWeekPageListBlocks failWeekPageListBlock = [error copy];
    if (_weekArry != nil && requestWeekPageListBlock) {
        requestWeekPageListBlock(_weekArry);
        return;
    }
    __weak id selfTemp = self;
    _weekArry = [[NSMutableArray alloc] initWithCapacity:5];
    _weekPage = @"2";
    static NSString *url = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%9C%AC%E5%91%A8%E6%8E%A8%E8%8D%90";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        if (requestWeekPageListBlock) {
            NSArray *arryTemp =  [selfTemp p_anasysisWeekPageArryWithResponseArry:responseObject];
            [_weekArry addObjectsFromArray: arryTemp];
            requestWeekPageListBlock(_weekArry);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failWeekPageListBlock){
        failWeekPageListBlock(error);
        }
        
    }];
    
}


// 刷新本周推荐数据
- (void)refreshWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error
{
    
    RequestWeekPageListBlocks requestWeekPageListBlock = [completion copy];
    FailedWeekPageListBlocks failWeekPageListBlock = [error copy];
    if (_weekArry != nil) {
        _weekArry = nil;
    }
    _weekPage = @"2";
    _weekArry = [[NSMutableArray alloc] initWithCapacity:5];
    __weak id selfTemp = self;
    static NSString *url = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%9C%AC%E5%91%A8%E6%8E%A8%E8%8D%90";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestWeekPageListBlock) {
            NSArray *arryTemp =  [selfTemp p_anasysisWeekPageArryWithResponseArry:responseObject];
            [_weekArry addObjectsFromArray: arryTemp];
            requestWeekPageListBlock(_weekArry);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failWeekPageListBlock){
            failWeekPageListBlock(error);
        }
        
    }];
    
}


// 加载更多本周推荐数据
- (void)loadMoreWeekPageListWithCompletion:(RequestWeekPageListBlocks)completion error:(FailedWeekPageListBlocks)error
{
    
    RequestWeekPageListBlocks requestWeekPageListBlock = [completion copy];
    FailedWeekPageListBlocks failWeekPageListBlock = [error copy];


    __weak id selfTemp = self;
    NSString *url = @"http://www.bundpic.com/api_app_ios_300.php?action=tag_article_list&tag=%E6%9C%AC%E5%91%A8%E6%8E%A8%E8%8D%90&pagenum=";
    url = [url stringByAppendingString:_weekPage];
    int pageTemp = [_weekPage intValue];
    _weekPage = [NSString stringWithFormat:@"%d",(pageTemp + 1)];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (requestWeekPageListBlock) {
            
            NSArray *arryTemp =  [selfTemp p_anasysisWeekPageArryWithResponseArry:responseObject];
            [_weekArry addObjectsFromArray: arryTemp];
            requestWeekPageListBlock(_weekArry);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failWeekPageListBlock){
            failWeekPageListBlock(error);
        }
        
    }];
    
}




// 获取新闻/文艺/时尚/生活数据
- (void)requestLifePageListWithType:(NSString *)type Completion:(RequestLifePageListBlocks)completion error:(FailedLifePageListBlocks)error
{
    
    if (type) {
        
        RequestLifePageListBlocks requestLifePagelistBlock = [completion copy];
        FailedLifePageListBlocks failedLifePagelistBlock = [error copy];
        
        __weak id selfTemp = self;
        NSString *url = @"http://www.bundpic.com/api_app_ios_300.php?action={_TYPE_}";
        url = [url stringByReplacingOccurrencesOfString:@"{_TYPE_}" withString:type];
        _lifePage = @"2";
        _lifeArry = [[NSMutableArray alloc] initWithCapacity:5];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
            if (requestLifePagelistBlock) {
                NSArray *arry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
                [_lifeArry addObjectsFromArray:arry];
                requestLifePagelistBlock(_lifeArry);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failedLifePagelistBlock) {
                failedLifePagelistBlock(error);
            }
            
        }];
        
    }
    
}



// 获取更多新闻/文艺/时尚/生活数据
- (void)lodeMoreLifePageListWithType:(NSString *)type Completion:(RequestLifePageListBlocks)completion error:(FailedLifePageListBlocks)error
{
    
    if (type) {
        
        RequestLifePageListBlocks requestLifePagelistBlock = [completion copy];
        FailedLifePageListBlocks failedLifePagelistBlock = [error copy];
        
        __weak id selfTemp = self;
        NSString *url = @"http://www.bundpic.com/api_app_ios_300.php?action={_TYPE_}&pagenum=";
        url = [url stringByReplacingOccurrencesOfString:@"{_TYPE_}" withString:type];
        url = [url stringByAppendingString:_lifePage];
        int pageTemp = [_lifePage intValue];
        _lifePage = [NSString stringWithFormat:@"%d",(pageTemp + 1)];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (requestLifePagelistBlock) {
                NSArray *arry = [selfTemp p_analysisHotPageListOfDataArry:responseObject];
                [_lifeArry addObjectsFromArray:arry];
                requestLifePagelistBlock(_lifeArry);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            if (failedLifePagelistBlock) {
                failedLifePagelistBlock(error);
            }
            
        }];
        
    }
    
}




#pragma mark -- private methods
// 解析首页信息
- (NSDictionary *)p_analysisHomePageListOfdataDic:(id)dataDic
{
    
    NSDictionary *dic = (NSDictionary *)dataDic;
    NSArray *arry1 = dic[@"headline"];
    NSMutableArray *headlineArry = [[NSMutableArray alloc]initWithCapacity:1];
    for (NSDictionary *newsDic in arry1) {
        
        FLYNews *news = [[FLYNews alloc]init];
        news.author = newsDic[@"author"];
        news.dateinfo = newsDic[@"dateinfo"];
        news.image = newsDic[@"image"];
        news.image_real_height = newsDic[@"image_real_height"];
        news.image_real_width = newsDic[@"image_real_width"];
        news.info = newsDic[@"info"];
        news.linkid = newsDic[@"linkid"];
        news.share_text = newsDic[@"share_text"];
        news.share_url = newsDic[@"share_url"];
        news.sortid = newsDic[@"sortid"];
        news.tag = newsDic[@"tag"];
        news.timeStamp = newsDic[@"timeStamp"];
        news.title = newsDic[@"title"];
        news.url = newsDic[@"url"];
        [headlineArry addObject:news];
    }
    
    NSArray *arry2 = dic[@"secondnews"];
    NSMutableArray *hotnewsArry = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *stylenewsArry = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *lifenewsArry = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableArray *culturenewsArry = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *secnewsDic in arry2) {
        FLYNews *news = [[FLYNews alloc]init];
        
        news.author = secnewsDic[@"author"];
        news.classify = secnewsDic[@"classify"];
        news.dateinfo = secnewsDic[@"dateinfo"];
        news.image = secnewsDic[@"image"];
        news.image_real_height = secnewsDic[@"image_real_height"];
        news.image_real_width = secnewsDic[@"image_real_width"];
        news.info = secnewsDic[@"info"];
        news.linkid = secnewsDic[@"linkid"];
        news.share_text = secnewsDic[@"share_text"];
        news.share_url = secnewsDic[@"share_url"];
        news.sortid = secnewsDic[@"sortid"];
        news.tag = secnewsDic[@"tag"];
        news.timeStamp = secnewsDic[@"timeStamp"];
        news.title = secnewsDic[@"title"];
        news.url = secnewsDic[@"url"];
        if ([news.classify isEqualToString:@"hot"]) {
            [hotnewsArry addObject:news];
        }
        if ([news.classify isEqualToString:@"style"]) {
            [stylenewsArry addObject:news];
        }
        
        if ([news.classify isEqualToString:@"life"]) {
            [lifenewsArry addObject:news];
        }
        if ([news.classify isEqualToString:@"culture"]) {
            [culturenewsArry addObject:news];
        }
        
        
        
    }
    NSDictionary *secNewsArryDic = @{@"时尚|style": stylenewsArry,@"热点|hot": hotnewsArry,@"生活|life": lifenewsArry,@"文化|culture": culturenewsArry};
    
    
    NSDictionary *homePageDataDic = @{@"headline": headlineArry,@"secnews" :secNewsArryDic};
    
    
    return homePageDataDic;
    
}



// 解析热门/精选数据
- (NSArray *)p_analysisHotPageListOfDataArry:(id)jsonArry
{
    
    NSArray *arry1 = (NSArray *)jsonArry;
    NSMutableArray *hotListArry = [[NSMutableArray alloc]initWithCapacity:1];
    for (NSDictionary *newsDic in arry1) {
        FLYNews *news = [[FLYNews alloc]init];
        news.author = newsDic[@"author"];
        news.dateinfo = newsDic[@"dateinfo"];
        news.image = newsDic[@"image"];
        news.image_real_height = newsDic[@"image_real_height"];
        news.image_real_width = newsDic[@"image_real_width"];
        news.info = newsDic[@"info"];
        news.linkid = newsDic[@"linkid"];
        news.share_text = newsDic[@"share_text"];
        news.share_url = newsDic[@"share_url"];
        news.sortid = newsDic[@"sortid"];
        news.tag = newsDic[@"tag"];
        news.timeStamp = newsDic[@"timeStamp"];
        news.title = newsDic[@"title"];
        news.url = newsDic[@"url"];
        [hotListArry addObject:news];
    }
    return hotListArry;
    
}





// 解析图文故事数据
- (NSArray *)p_anasysisImage_textWithResponseArry:(id)responseObject
{
    
    NSArray *resPonseArry = (NSArray *)responseObject;
    
    NSMutableArray *image_textArry = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *objDic in resPonseArry) {
        
        FLYimage_textModel *image_text = [[FLYimage_textModel alloc] init];
        image_text.first_image = objDic[@"first_image"];
        image_text.image_textID = objDic[@"image_textID"];
        image_text.share_url = objDic[@"share_url"];
        image_text.title = objDic[@"title"];
        image_text.url = objDic[@"url"];
        NSDictionary *newsDic = objDic[@"article_url"];
        FLYNews *news = [[FLYNews alloc] init];
        news.author = newsDic[@"author"];
        news.dateinfo = newsDic[@"dateinfo"];
        news.image = newsDic[@"image"];
        news.image_real_height = newsDic[@"image_real_height"];
        news.image_real_width = newsDic[@"image_real_width"];
        news.info = newsDic[@"info"];
        news.linkid = newsDic[@"linkid"];
        news.share_text = newsDic[@"share_text"];
        news.share_url = newsDic[@"share_url"];
        news.sortid = newsDic[@"sortid"];
        news.tag = newsDic[@"tag"];
        news.timeStamp = newsDic[@"timeStamp"];
        news.title = newsDic[@"title"];
        news.url = newsDic[@"url"];
        image_text.news = news;
        
        [image_textArry addObject:image_text];
        
    }
    
    return image_textArry;
    
}



// 解析本周推荐数据
- (NSArray *)p_anasysisWeekPageArryWithResponseArry:(id)responseObject
{
    
    NSArray *arry1 = (NSArray *)responseObject;
    NSMutableArray *weekListArry = [[NSMutableArray alloc]initWithCapacity:1];
    for (NSDictionary *newsDic in arry1) {
        FLYNews *news = [[FLYNews alloc]init];
        news.author = newsDic[@"author"];
        news.dateinfo = newsDic[@"dateinfo"];
        news.image = newsDic[@"image"];
        news.image_real_height = newsDic[@"image_real_height"];
        news.image_real_width = newsDic[@"image_real_width"];
        news.info = newsDic[@"info"];
        news.linkid = newsDic[@"linkid"];
        news.share_text = newsDic[@"share_text"];
        news.share_url = newsDic[@"share_url"];
        news.sortid = newsDic[@"sortid"];
        news.tag = newsDic[@"tag"];
        news.timeStamp = newsDic[@"timeStamp"];
        news.title = newsDic[@"title"];
        news.url = newsDic[@"url"];
        [weekListArry addObject:news];
    }
    return weekListArry;
    
}





@end
