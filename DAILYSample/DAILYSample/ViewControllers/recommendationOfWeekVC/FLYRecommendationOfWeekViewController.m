//
//  FLYRecommendationOfWeekViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYRecommendationOfWeekViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "FLYNetWorkingManage.h"
#import "FLYHomePageTableViewCell.h"
#import "FLYNews.h"
#import "MJRefresh.h"
#import "FLYReadingInWebViewController.h"
@interface FLYRecommendationOfWeekViewController ()

{
    __block NSArray *_weekArry;
    UITableView *_weekTableView;
    UIActivityIndicatorView *_juhua;
    UIView *_coverView;
}

- (void)loadWeekListWithNetWorking;

@end

@implementation FLYRecommendationOfWeekViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"本周推荐";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 标题颜色设置
    UIColor *color = [UIColor colorWithRed:33.00/255.00 green:186.00/255.00 blue:157.00/255.00 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 标题字体
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial Rounded MT Bold" size:20], NSFontAttributeName, nil]];
    
    
    // tableview
    _weekTableView = [[UITableView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _weekTableView.delegate = self;
    _weekTableView.dataSource = self;
    [self.view addSubview:_weekTableView];
    
    
    // 覆盖图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_coverView];
    
    
    // 菊花
    _juhua = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    [self.view addSubview:_juhua];
    
    [_juhua startAnimating];
    // navButton
    [self setupLeftMenuButton];
    // 加载数据
    [self loadWeekListWithNetWorking];
    
    
    
    [_weekTableView addHeaderWithTarget:self action:@selector(upWeekUI)];
    [_weekTableView addFooterWithTarget:self action:@selector(loadMoreWeekList)];
    
}

#pragma mark -- 上下加载
- (void)upWeekUI
{
    [self refreshWeekListWithNetWorking];
}

-(void)loadMoreWeekList
{
    [self loadMoreWeekListWithNetWorking];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- 加载网络数据
- (void)loadWeekListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] requestWeekPageListWithCompletion:^(NSArray *array) {
        
        _weekArry = array;
        [_weekTableView reloadData];
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        
    }error:^(NSError *error) {
        
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        
    }];
    
}

// 刷新
- (void)refreshWeekListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] refreshWeekPageListWithCompletion:^(NSArray *array) {
        
        _weekArry = array;
        [_weekTableView reloadData];
        [_weekTableView headerEndRefreshing];
        
    }error:^(NSError *error) {
        
        [_weekTableView headerEndRefreshing];
        
    }];
    
}


// 加载更多

- (void)loadMoreWeekListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] loadMoreWeekPageListWithCompletion:^(NSArray *array) {
        
        _weekArry = array;
        [_weekTableView reloadData];
        [_weekTableView footerEndRefreshing];
        
    }error:^(NSError *error) {
        
        [_weekTableView footerEndRefreshing];
        
    }];
    
}


#pragma mark --TableViewDelegate
// section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _weekArry.count;
    
}


// heigthForRow

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYNews *news = _weekArry[indexPath.row];
    float heigth = [FLYHomePageTableViewCell setCellHeigthWithNews:news];
    return heigth;
    
}


//cellForRow
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    FLYHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[FLYHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    FLYNews *news = _weekArry[indexPath.row];
    [cell setcellInputViewDataAndFramWithNews:news];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
    
}





// DidSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYNews *news = _weekArry[indexPath.row];
    FLYReadingInWebViewController *readVC = [[FLYReadingInWebViewController alloc] init];
    readVC.news = news;
    [self.navigationController pushViewController:readVC animated:YES];
    
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
