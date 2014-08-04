//
//  FLYLifeViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYLifeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "FLYNetWorkingManage.h"

#import "FLYNewsTableViewCell.h"
#import "FLYAdaptPicTableViewCell.h"
#import "FLYNews.h"
#import "MJRefresh.h"
#import "FLYReadingInWebViewController.h"
@interface FLYLifeViewController ()

{
    __block NSArray *_lifeArry;
    UITableView *_lifeTableView;
    UIActivityIndicatorView *_juhua;
    UIView *_coverView;
}

@end

@implementation FLYLifeViewController

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
    self.navigationItem.title = self.type;
    // 标题颜色设置
    UIColor *color = [UIColor colorWithRed:33.00/255.00 green:186.00/255.00 blue:157.00/255.00 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 标题字体
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial Rounded MT Bold" size:20], NSFontAttributeName, nil]];
    
    
    
    
    // tableview
    _lifeTableView = [[UITableView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64) style:UITableViewStylePlain];
//    _lifeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _lifeTableView.delegate = self;
    _lifeTableView.dataSource = self;
    [self.view addSubview:_lifeTableView];
    
    
    // 覆盖图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_coverView];
    
    
    // 菊花
    _juhua = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    [self.view addSubview:_juhua];
    
    
    // navButton
    [self setupLeftMenuButton];
    [_juhua startAnimating];
    // 加载数据
    [self loadLifeListWithNetWorking];
    
    
    [_lifeTableView addFooterWithTarget:self action:@selector(loadMoreLifeList)];
    [_lifeTableView addHeaderWithTarget:self action:@selector(uplifeUI)];
    
    
    
    
}


#pragma mark -- 上下加载
- (void)uplifeUI
{
    [self refreshLifeListWithNetWorking];
    
}


- (void)loadMoreLifeList
{
    [self loadMoreLifeListWithNetWorking];
    
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


#pragma mark -- netWorking
- (void)loadLifeListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] requestLifePageListWithType:self.type Completion:^(NSArray *array) {
        
        _lifeArry = array;
        [_lifeTableView reloadData];
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        
    } error:^(NSError *error) {
        
        [_juhua stopAnimating];
        
    }];
    
}


- (void)refreshLifeListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] requestLifePageListWithType:self.type Completion:^(NSArray *array) {
        
        _lifeArry = array;
        [_lifeTableView reloadData];
        [_lifeTableView headerEndRefreshing];
        
    } error:^(NSError *error) {
        
        [_lifeTableView headerEndRefreshing];
        
    }];
    
}



- (void)loadMoreLifeListWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] lodeMoreLifePageListWithType:self.type Completion:^(NSArray *array) {
        
        _lifeArry = array;
        [_lifeTableView reloadData];
        [_lifeTableView footerEndRefreshing];
        
    } error:^(NSError *error) {
        
        [_lifeTableView footerEndRefreshing];
        
    }];
    
}




#pragma mark -- tableviewDelegate
// numOfSec
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// numOfRow
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _lifeArry.count;
    
}

// heightOfRow
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLYNews *news = _lifeArry[indexPath.row];
    if (indexPath.row == 0) {
        return [FLYAdaptPicTableViewCell setAdaptCellHeigthWithNews:news];
    }
    return [FLYNewsTableViewCell setNewsCellHeigthWithNews:news];
    
}


// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FLYNews *news = _lifeArry[indexPath.row];
    if (indexPath.row == 0) {
        static NSString *indentifier = @"cell1";
        FLYAdaptPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil) {
            cell = [[FLYAdaptPicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        [cell setAdaptcellInputViewDataAndFramWithNews:news];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    static NSString *indentifier1 = @"cell2";
    FLYNewsTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:indentifier1];
    if (cell1 == nil) {
        cell1 = [[FLYNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier1];
    }
    
    [cell1 setNewscellInputViewDataAndFramWithNews:news];
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell1;
    
}



// didSelect
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYNews *news = _lifeArry[indexPath.row];
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
