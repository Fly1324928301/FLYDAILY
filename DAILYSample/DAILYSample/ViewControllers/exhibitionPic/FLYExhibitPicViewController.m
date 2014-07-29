//
//  FLYExhibitPicViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-26.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYExhibitPicViewController.h"
#import "FLYExhibitPicViewCell.h"
#import "FLYAnasilyWebViewDate.h"
#import "FLYcollectionView.h"
#import "FLYListPicLunboViewController.h"
@interface FLYExhibitPicViewController ()

{
    UICollectionView *_collectionView;
    __block NSArray *_collectionArry;
    FLYcollectionView *_collectionBar;
    UIActivityIndicatorView *_juhua;
}

@end

@implementation FLYExhibitPicViewController

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
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:10];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
    flowLayout.footerReferenceSize = CGSizeMake(0, 44);
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, 300, self.view.frame.size.height ) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    [self loadImageArry];
    
    _collectionBar = [[FLYcollectionView alloc] initWithFrame:Rect(0, self.view.frame.size.height - 44, 320, 44)];
    [self.view addSubview:_collectionBar];
    UITapGestureRecognizer *webTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [_collectionBar.backView addGestureRecognizer:webTap];
    UITapGestureRecognizer *backListTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [_collectionBar.toWebView addGestureRecognizer:backListTap];
    
    UITapGestureRecognizer *listPicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(listPicClick)];
    [_collectionBar.shareView addGestureRecognizer:listPicTap];
    _collectionBar.shareView.userInteractionEnabled = NO;
    
}

- (void)backClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)listPicClick
{
    if (_collectionView != nil) {
    FLYListPicLunboViewController *listVC = [[FLYListPicLunboViewController alloc] init];
    listVC.imgArry = _collectionArry;
    listVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:listVC animated:YES completion:nil];
    }
    
}






// imgUrlArry
- (void)loadImageArry
{
    
    [[FLYAnasilyWebViewDate shareAnasilyWebViewData] loadExhibitPicArryWithHtmlStr:self.htmlStr sucess:^(NSArray *picArry) {
        
        _collectionArry = picArry;
        [_collectionView reloadData];
        [_collectionBar.shareView setUserInteractionEnabled:YES];
        [_juhua stopAnimating];
        
    } failed:^(NSString *error) {
        
        [_juhua stopAnimating];
        
    }];
    
}



#pragma mark -- collectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _collectionArry.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    [collectionView registerClass:[FLYExhibitPicViewCell class] forCellWithReuseIdentifier:indentifier];
    FLYExhibitPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    
    cell.cellImageView.image = _collectionArry[indexPath.row];
    
    return cell;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_collectionArry.count != 0){
    UIImage *image = _collectionArry[indexPath.row];
    float heigth = 145 * image.size.height / image.size.width;
    CGSize size = CGSizeMake(145, heigth);
    return size;
    }
    CGSize size = CGSizeMake(0, 0);
    return size;
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

@end
