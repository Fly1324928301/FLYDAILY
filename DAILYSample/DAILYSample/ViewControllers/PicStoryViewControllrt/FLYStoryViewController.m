//
//  FLYStoryViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-24.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYStoryViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "FLYNetWorkingManage.h"

#import "FLYimage-textModel.h"
#import "FLYImageTableViewCell.h"
#import "FLYPicStory2ViewController.h"
@interface FLYStoryViewController ()


{
    
    UITableView *_storyTableView;
    __block NSArray *_storyArry;
    UIActivityIndicatorView *_juhua;
    UIView *_coverView;
    
}


@end

@implementation FLYStoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.navigationItem.title = @"图片故事";
        
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
    
    
    // tableView
    _storyTableView = [[UITableView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    _storyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _storyTableView.delegate = self;
    _storyTableView.dataSource = self;
    [self.view addSubview:_storyTableView];
    
    // 覆盖图
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_coverView];
    
    // 菊花
    _juhua = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _juhua.center = self.view.center;
    [self.view addSubview:_juhua];
    [_juhua startAnimating];
    
    
    // navButton
    [self setupLeftMenuButton];
    // 加载数据
    [self loadStoryListWithNetWorking];
    
    
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



#pragma mark -- NetWorking
- (void)loadStoryListWithNetWorking
{
    [[FLYNetWorkingManage currentNetWorkManager] requestImage_textPageListWithCompletion:^(NSArray *array) {
       
        _storyArry = array;
        [_storyTableView reloadData];
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

// rowNumOfsec
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _storyArry.count;
    
}

// heigth
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 180;
    
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indentifier = @"cell";
    FLYImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[FLYImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    FLYimage_textModel *picStoryModel = _storyArry[indexPath.row];
    [cell setcellInputViewDataAndFramWithFLYimage_textModel:picStoryModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FLYimage_textModel *picmodel = _storyArry[indexPath.row];
    FLYPicStory2ViewController *nextPicStoryVC = [[FLYPicStory2ViewController alloc] init];
    
    nextPicStoryVC.img_txtModel = picmodel;
//    NSLog(@"....%@",picmodel.news.url);
    [self presentViewController:nextPicStoryVC animated:YES completion:nil];
    
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
