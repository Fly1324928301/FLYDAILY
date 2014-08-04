//
//  FLYReadingInWebViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-25.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYReadingInWebViewController.h"
#import "UIWebView+AFNetworking.h"
#import "FLYAnasilyWebViewDate.h"
#import "FLYWebBarView.h"
#import "FLYExhibitPicViewController.h"
#import "UMSocialDataService.h"
#import "UMSocial.h"
@interface FLYReadingInWebViewController ()

{
    
    __block UIWebView *_webView;
    NSString *_urlStr;
    __block NSString *_htmlTemp;
    FLYWebBarView *_webBarView;
    UIActivityIndicatorView *_juhua;
//    UIImageView *imageView;
    
    
}
// 加载Web
- (void)loadWebView;

@end

@implementation FLYReadingInWebViewController




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 菊花
    _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    
    
    // webView
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64)];
    
    [self.view addSubview:_webView];
    _webView.scrollView.delegate = self;
    _webView.delegate = self;
    
    _webBarView = [[FLYWebBarView alloc] initWithFrame:Rect(0, self.view.frame.size.height - 108, 320, 44)];
    [self.view addSubview:_webBarView];
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    // 加载Web
    [self loadWebView];
    
    
    UITapGestureRecognizer *webTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [_webBarView.backView addGestureRecognizer:webTap];
    
    UITapGestureRecognizer *previewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewClick)];
    [_webBarView.previewView addGestureRecognizer:previewTap];

    
    UITapGestureRecognizer *reloadTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadClick)];
    [_webBarView.reloadView addGestureRecognizer:reloadTap];
//    NSLog(@"...%@",self.news.url);
    
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shreClick)];
    [_webBarView.shareView addGestureRecognizer:shareTap];
}



// webBar点击

- (void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)previewClick
{
    
    FLYExhibitPicViewController *exhibitVC = [[FLYExhibitPicViewController alloc] init];
    exhibitVC.htmlStr = _htmlTemp;
    [self presentViewController:exhibitVC animated:YES completion:nil];
    
}


// 分享
- (void)shreClick
{
    
    NSString *shareUrl = self.news.share_url;
    NSString *shareText = self.news.share_text;
    shareText = [shareText stringByAppendingString:shareUrl];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UmengAppkey
                                      shareText:shareText
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren, UMShareToDouban, UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:nil];
    
}



- (void)reloadClick
{
    
    [self loadWebView];
    
}


// 加载Web
- (void)loadWebView
{
    
    [[FLYAnasilyWebViewDate shareAnasilyWebViewData] loadWebViewWithUrlStr:self.news.url sucess:^(NSString *htmlStr) {
        
        [_webView loadHTMLString:htmlStr baseURL:nil];
        _htmlTemp = htmlStr;

        
        
    } failed:^(NSError *error) {
        [_juhua stopAnimating];
        
    }];
    
    

    
}





#pragma mark -- WebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    

    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [_juhua stopAnimating]; 

    
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark -- scroViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    if (velocity.y < 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _webBarView.center = CGPointMake(160, self.view.frame.size.height - 22);
        }];
       
    }
    if (velocity.y > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _webBarView.center = CGPointMake(160, self.view.frame.size.height + 22);
        }];
        
    }
    
}



@end
