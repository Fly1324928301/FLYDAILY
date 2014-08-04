//
//  FLYSettingViewController.m
//  FLYDAILY
//
//  Created by fenglianyi on 14-8-1.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYSettingViewController.h"
#import "FLYMyView.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
@interface FLYSettingViewController ()

{
    UITableView *_settingtableView;
    NSArray *_setArry;
}

@end

@implementation FLYSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加navButton
    [self setupLeftMenuButton];
    [self setNavigationBar];

    _setArry = @[@"清除缓存",@"反馈信息",@"关于我们"];
    [self setTableView];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



#pragma mark -- setingNavBar
- (void)setNavigationBar
{
    
    UIColor *color = [UIColor colorWithRed:33.00/255.00 green:186.00/255.00 blue:157.00/255.00 alpha:1];
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"Arial Rounded MT Bold" size:20], NSFontAttributeName, nil]];
    
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


#pragma mark -- settingBackView
- (void)setbackView
{
    
    FLYMyView *backView = [[FLYMyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view = backView;
    
}


#pragma mark -- settingTableView
- (void)setTableView
{
    
    _settingtableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _settingtableView.delegate = self;
    _settingtableView.dataSource = self;
    _settingtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    FLYMyView *backView = [[FLYMyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _settingtableView.backgroundView = backView;
    [self.view addSubview:_settingtableView];
    
}




#pragma mark -- tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
    
    
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *indentifier = @"cell";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row >= 3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Courier New" size:18];
        cell.textLabel.text = _setArry[indexPath.row - 3];
        
        
    }
    
    
    return cell;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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
