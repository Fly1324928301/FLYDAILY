//
//  FLYHandPickViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYHandPickViewController.h"
#import "FLYNetWorkingManage.h"
#import "FLYNews.h"
#import "FLYHomePageTableViewCell.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

#import "FLYReadingInWebViewController.h"
@interface FLYHandPickViewController ()

{
    
    UITableView *_hptableView;
    UIActivityIndicatorView *_juhua;
    __block NSArray *_handPickArry;
    UIView *_coverView;
    
}


@end

@implementation FLYHandPickViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"每日精选";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    // navigationController
    UIColor *color = [UIColor colorWithRed:33.00/255.00 green:186.00/255.00 blue:157.00/255.00 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial Rounded MT Bold" size:20], NSFontAttributeName, nil]];
    
    // tableView
    _hptableView = [[UITableView alloc]initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _hptableView.delegate = self;
    _hptableView.dataSource = self;
    [self.view addSubview:_hptableView];
    
    // 加载数据
    [self loadHandPickWithNetWorking];
    
    // 覆盖图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_coverView];
    
    
    _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    

    
    // 添加navButton
    [self setupLeftMenuButton];
    
    
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


#pragma mark -- netWorking
- (void)loadHandPickWithNetWorking
{
    
    [[FLYNetWorkingManage currentNetWorkManager] requestHandPickPageListWithCompletion:^(NSArray *array) {
        
        _handPickArry = array;
        [_hptableView reloadData];
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        
    } error:^(NSError *error) {
        
        [_juhua stopAnimating];
        [_coverView removeFromSuperview];
        
    }];
    
}


#pragma mark -- tableViewDelegate

// section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// rowOfSec
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _handPickArry.count;
}

// heigthForCell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYNews *news = _handPickArry[indexPath.row];
    float heigth = [FLYHomePageTableViewCell setCellHeigthWithNews:news];
    return heigth;
    
}


// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    FLYHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[FLYHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FLYNews *news = _handPickArry[indexPath.row];
    [cell setcellInputViewDataAndFramWithNews:news];
    
    return cell;
    
}



// didSelect
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYNews *news = _handPickArry[indexPath.row];
    
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
