//
//  FLYListPicLunboViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-26.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYListPicLunboViewController.h"
#import "TFTScrillImageView.h"
#import "FLYListPicCollectionViewCell.h"
@interface FLYListPicLunboViewController ()
{
    TFTScrillImageView *_lunBoView;
    UICollectionView *_collectionView;
    
    
}
@end

@implementation FLYListPicLunboViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:0];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    flowLayout.footerReferenceSize = CGSizeMake(0, 0);
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, 320, self.view.frame.size.height - 20 ) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    _collectionView.pagingEnabled = YES;
    
    


    
//    _lunBoView = [[TFTScrillImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 400) images:self.imgArry];
//    [self.view addSubview:_lunBoView];
    
    

    
    

    
    
    
    
    
    UIView *barview = [[UIView alloc] initWithFrame:Rect(0, self.view.frame.size.height - 44, 320, 44)];
    barview.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:barview];
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:Rect(24, 0, 50, 40)];
    backImgView.image = [UIImage imageNamed:@"BackIMG@2x.png"];
    [barview addSubview:backImgView];
    UIImageView *imageSepView = [[UIImageView alloc] initWithFrame:Rect(0, -4, 320, 5)];
    imageSepView.image = [UIImage imageNamed:@"tool_footersep.png"];
    [barview addSubview:imageSepView];
    
    backImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [backImgView addGestureRecognizer:backTap];
    
    
}


- (void) backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    return 100000;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    [collectionView registerClass:[FLYListPicCollectionViewCell class] forCellWithReuseIdentifier:indentifier];
    FLYListPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    NSInteger cout = self.imgArry.count;
    cell.cellImageView.image = self.imgArry[indexPath.row%cout];
    
    return cell;
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cout = self.imgArry.count;
    UIImage *image = self.imgArry[indexPath.row%cout];
    float width = 320;
    float heigth = 320 * image.size.height / image.size.width;
    CGSize size = CGSizeMake(width,heigth);
    return size;

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
