//
//  FLYPicStory2ViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-28.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYPicStory2ViewController.h"
#import "FLYPicStoryPicModel.h"
#import "FLYAnasilyWebViewDate.h"
#import "UIImageView+WebCache.h"
#import "FLYStoryViewInfoCell.h"
#import "FLYInfoView.h"
#import "FLYcollectionView.h"
#import "FLYLargePicView.h"
#import "FLYPicStoryReadInWebViewVC.h"
#import "FLYStory2ListPicViewController.h"
@interface FLYPicStory2ViewController ()

{
    __block UICollectionView *_collectionView;
    __block NSArray *_listArry;
    __block NSArray *_picModelArry;
    UIActivityIndicatorView *_juhua;
    FLYInfoView *_infoView;
    FLYLargePicView *_largeView;
    UIView *_coverView;
    // barView
    FLYcollectionView *_barView;
}

@end

@implementation FLYPicStory2ViewController




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
    _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    _coverView = [[UIView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height)];
    
    // collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:0];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    flowLayout.footerReferenceSize = CGSizeMake(0, 0);
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, 320, 240) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    _collectionView.pagingEnabled = YES;

    
    // InfoView
    _infoView = [[FLYInfoView alloc] initWithFrame:Rect(0, 270, 320, self.view.frame.size.height - 270)];
    [self.view addSubview:_infoView];
    
    
    // barView
    _barView = [[FLYcollectionView alloc] initWithFrame:Rect(0, self.view.frame.size.height - 44, 320, 44)];
    [self.view addSubview:_barView];
    
    [self.view addSubview:_coverView];
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    [self loadPic];
    
    
    // barViewtap
    UITapGestureRecognizer *webTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [_barView.backView addGestureRecognizer:webTap];
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(readNews)];
    [_barView.toWebView addGestureRecognizer:newsTap];
    UITapGestureRecognizer *listPicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(listPicClick)];
    [_barView.shareView addGestureRecognizer:listPicTap];
    // 关listPic交互
    _barView.shareView.userInteractionEnabled = NO;
    
}



// 返回
- (void)backClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



// 阅读新闻
- (void)readNews
{
    
    FLYPicStoryReadInWebViewVC *storyVC = [[FLYPicStoryReadInWebViewVC alloc] init];
    storyVC.newsUrlStr = self.newsUrlStr;
    storyVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:storyVC animated:YES completion:nil];
    
}

// 展示图片
- (void)listPicClick
{
    
    FLYStory2ListPicViewController *storyListVC = [[FLYStory2ListPicViewController alloc] init];
    storyListVC.picArry = _listArry;
    storyListVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:storyListVC animated:YES completion:nil];
    
}




// 加载data
- (void)loadPic
{
    
    
    [[FLYAnasilyWebViewDate shareAnasilyWebViewData] loadPicStoryTHArryWithUrlStr:self.picurlStr sucess:^(NSDictionary *picdataDic) {
        _listArry = picdataDic[@"imageArry"];
        _picModelArry = picdataDic[@"modelArry"];
        [_juhua stopAnimating];
        [_collectionView reloadData];
        [_coverView removeFromSuperview];
        _barView.shareView.userInteractionEnabled = YES;
        
    } failed:^(NSError *error) {
        
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
    }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- collectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _listArry.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    [collectionView registerClass:[FLYStoryViewInfoCell class] forCellWithReuseIdentifier:indentifier];
    FLYStoryViewInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.cellImageView.image = _listArry[indexPath.row];
    
    FLYPicStoryPicModel *picModel = (FLYPicStoryPicModel *)_picModelArry[indexPath.row];
    [_infoView setlabelInfoWithPicModel:picModel];
    
    return cell;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize size = CGSizeMake(320, 240);
    return size;
    
}



// 选中放大
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    _largeView = [[FLYLargePicView alloc] initWithFrame:Rect(0, 20, 320, 240)];
    UIImage *image = _listArry[indexPath.row];
    _largeView.largeimgView.image = image;
    [self.view addSubview:_largeView];

    [UIView animateWithDuration:0.7 animations:^{
        _largeView.frame = Rect(0, 20, 320, 568);
        _largeView.largeScrollView.frame = Rect(0, 0, 320, 568);
        _largeView.largeimgView.frame = Rect(0, 0, 757, 568);
        
    }];
    
    UITapGestureRecognizer *clearTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearView)];
    [_largeView.largeimgView addGestureRecognizer:clearTap];
    

    
    
    
}

// 点击放大图片还原
- (void)clearView
{
    _largeView.largeScrollView.contentOffset = CGPointMake(0, 0);
    [UIView animateWithDuration:0.7 animations:^{
        _largeView.largeimgView.frame = Rect(0, 0, 320, 240);
        _largeView.largeScrollView.frame = Rect(0, 0, 320, 240);
        _largeView.frame = Rect(0, 20, 320, 240);
        
        
    } completion:^(BOOL finished) {
        [_largeView removeFromSuperview];
    }];
    
    
    
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

@end
