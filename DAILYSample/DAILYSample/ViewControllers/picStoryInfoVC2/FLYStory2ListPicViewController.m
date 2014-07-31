//
//  FLYStory2ListPicViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-29.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYStory2ListPicViewController.h"
#import "FLYStory2ListPicViewCell.h"

@interface FLYStory2ListPicViewController ()

{
    UICollectionView *_collectionView;
   
}

@end

@implementation FLYStory2ListPicViewController

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
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumLineSpacing:10];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
    flowLayout.footerReferenceSize = CGSizeMake(0, 44);
    self.view.backgroundColor = [UIColor whiteColor];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, 300, self.view.frame.size.height - 54 ) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
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

// webBar点击

- (void)backClick
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
    
    return self.picArry.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    [collectionView registerClass:[FLYStory2ListPicViewCell class] forCellWithReuseIdentifier:indentifier];
    FLYStory2ListPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    cell.cellImageView.image = self.picArry[indexPath.row];
    return cell;
    
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    CGSize size = CGSizeMake(145, 120);
    return size;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getimgindex" object:[NSNumber numberWithInteger:indexPath.row]];
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
