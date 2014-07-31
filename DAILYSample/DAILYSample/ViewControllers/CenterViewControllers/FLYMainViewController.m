//
//  FLYMainViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-21.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYMainViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
//#import <QuartzCore/QuartzCore.h>
#import "FLYNetWorkingManage.h"
#import "FLYlunBoTableViewCell.h"
#import "FLYNews.h"
#import "FLYHomePageTableViewCell.h"
#import "FLYReadingInWebViewController.h"
#import "MJRefresh.h"
@interface FLYMainViewController ()

{
    
    __block NSDictionary *_homePageDic;
    __block NSArray *_headlineArry;
    UITableView *_tableVW;
    UIActivityIndicatorView *_juhua;
    UIView *_coverView;
    
}




// 根据indexPath获取行高
- (float)p_getCellHeigthFromDicWithCellIndexPath:(NSIndexPath *)indexPath;

@end

@implementation FLYMainViewController

- (void)dealloc
{
//    NSLog(@".........");
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.navigationItem.title = @"FLYDAILY";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *color = [UIColor colorWithRed:33.00/255.00 green:186.00/255.00 blue:157.00/255.00 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial Rounded MT Bold" size:20], NSFontAttributeName, nil]];
//    NSLog(@"%@", [UIFont familyNames]);
    _tableVW = [[UITableView alloc]initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableVW];
    _tableVW.delegate = self;
    _tableVW.dataSource = self;
    
    // 覆盖图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_coverView];
    
    
    _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 添加navButton
    [self setupLeftMenuButton];
    // 加载网络数据
    [self loadHomeListWithNetWorking];
    
   // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getIndex:) name:@"getindex" object:nil];
    
    
    // 下拉刷新
    [_tableVW addHeaderWithTarget:self action:@selector(upui)];
}


// 下啦刷新
- (void)upui
{
    [_juhua startAnimating];
    // 加载网络数据
    [self refreshHomeListWithNetWorking];
    
}



// 通知
- (void)getIndex:(NSNotification *)notification
{
    NSNumber *num = (NSNumber *) notification.object;
    int k = [num intValue];
    FLYNews *news = _headlineArry[k];
    FLYReadingInWebViewController *readVC = [[FLYReadingInWebViewController alloc] init];
    readVC.news = news;
    [self.navigationController pushViewController:readVC animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// leftButtonItem
-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}
// leftClick
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -- 加载网络数据
- (void)loadHomeListWithNetWorking
{
    
    
    [[FLYNetWorkingManage currentNetWorkManager] requestHomePageListWithCompletion:^(NSDictionary *dictionary) {
        _homePageDic = dictionary;
        _headlineArry = _homePageDic[@"headline"];
        
        [_tableVW reloadData];
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        

    }
     error:^(NSError *error) {
         
         [_juhua stopAnimating];
         [_coverView removeFromSuperview];
         
     }];
    
    
}



- (void)refreshHomeListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] refreshHomePageListWithCompletion:^(NSDictionary *dictionary) {
       
        _homePageDic = dictionary;
        _headlineArry = _homePageDic[@"headline"];
        [_tableVW headerEndRefreshing];
        [_tableVW reloadData];
        
        
    } error:^(NSError *error) {
        
        [_tableVW headerEndRefreshing];
        
    }];
    
    
}






#pragma mark -- tableView    delegate
// section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSDictionary *dic = _homePageDic[@"secnews"];
    NSArray *arry = dic.allKeys;
    return arry.count+1;
    
}

// rowNum
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self p_getCountOfRowInSection:section];
}


// heigth
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self p_getCellHeigthFromDicWithCellIndexPath:indexPath];
    
}


// headtitle
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section < 1) return nil;
    NSDictionary *dicTemp = _homePageDic[@"secnews"];
    NSArray *keyArray = dicTemp.allKeys;
    return keyArray[section - 1];
    
}





// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *indentifier = @"cell";
        FLYlunBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil) {
            cell = [[FLYlunBoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            
        }
        [cell setLunBoViewWithHeadlineArry:_headlineArry];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
    static NSString *indentifier = @"listCell";
    FLYHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[FLYHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }

    FLYNews *news = [self p_getNewsWithIndexPath:indexPath];
    [cell setcellInputViewDataAndFramWithNews:news];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}




#pragma mark -- private methods
// 根据indexPath获取行高
- (float)p_getCellHeigthFromDicWithCellIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)return 325;
    
    FLYNews *news = [self p_getNewsWithIndexPath:indexPath];
    
    return [FLYHomePageTableViewCell setCellHeigthWithNews:news];
    
    
}



// 根据section设置Row排版
- (NSInteger)p_getCountOfRowInSection:(NSInteger)section
{
    
    if (section == 0)return 1;
    
    NSDictionary *dicTemp = _homePageDic[@"secnews"];
    NSArray *keyArray = dicTemp.allKeys;
    NSArray *objArray = dicTemp[keyArray[section-1]];
    return objArray.count;
    
}


// 根据indexPath获取News对象
- (FLYNews *)p_getNewsWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 1)return nil;
    NSDictionary *dicTemp = _homePageDic[@"secnews"];
    NSArray *keyArray = dicTemp.allKeys;
    NSArray *objArray = dicTemp[keyArray[indexPath.section-1]];
    FLYNews *news = objArray[indexPath.row];
    return news;
}



// 选中查看详细
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section > 0) {
        FLYNews *newsTemp = [self p_getNewsWithIndexPath:indexPath];
        FLYReadingInWebViewController *readingWebVC = [[FLYReadingInWebViewController alloc] init];
        readingWebVC.news = newsTemp;
        [self.navigationController pushViewController:readingWebVC animated:YES];
        
    }
    

    
    
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
