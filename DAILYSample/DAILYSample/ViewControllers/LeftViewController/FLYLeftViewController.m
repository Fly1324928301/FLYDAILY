//
//  FLYLeftViewController.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-21.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYLeftViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMNavigationController.h"

#import "FLYMainViewController.h"
#import "FLYHotViewController.h"
#import "FLYHandPickViewController.h"
#import "FLYStoryViewController.h"
#import "FLYRecommendationOfWeekViewController.h"
#import "FLYLifeViewController.h"
@interface FLYLeftViewController ()

@property (nonatomic, strong) UITableView *tbView;
@property (nonatomic, strong) NSArray *array;

@end

@implementation FLYLeftViewController

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
    
    self.array = @[@"首页",@"热门",@"每日精选",@"图片故事",@"本周推荐",@[@"新闻",@"文艺",@"时尚",@"生活"]];
    self.tbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 175, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    self.tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tbView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 5) return 4;
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 3;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:16];
    if (indexPath.section == 5) {
        cell.textLabel.text = self.array[indexPath.section][indexPath.row];
    }
    if (indexPath.section != 5) {
        cell.textLabel.text = self.array[indexPath.section];
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.section == 0) {
        FLYMainViewController *mainVC = [[FLYMainViewController alloc] init];
        UINavigationController *nav = [[MMNavigationController alloc]initWithRootViewController:mainVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
    }
    
    if (indexPath.section == 1) {
        FLYHotViewController *hotVC = [[FLYHotViewController alloc] init];
        UINavigationController *nav = [[MMNavigationController alloc]initWithRootViewController:hotVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
    }
    
    if (indexPath.section == 2) {
        FLYHandPickViewController *handPickVC = [[FLYHandPickViewController alloc]init];
        UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:handPickVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
    }
    if (indexPath.section == 3) {
        FLYStoryViewController *StoryVC = [[FLYStoryViewController alloc] init];
        UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:StoryVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
        
    }
    
    if (indexPath.section == 4) {
        FLYRecommendationOfWeekViewController *recommendOfWeekVC = [[FLYRecommendationOfWeekViewController alloc] init];
        UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:recommendOfWeekVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
        
    }
    
    if (indexPath.section == 5) {
        FLYLifeViewController *lifeVC = [[FLYLifeViewController alloc] init];
        switch (indexPath.row) {
            case 0:
                lifeVC.type = @"news";
                break;
            case 1:
                lifeVC.type = @"culture";
                break;
            case 2:
                lifeVC.type = @"style";
                break;
            case 3:
                lifeVC.type = @"life";
                break;
            default:
                break;
        }
        UINavigationController *nav = [[MMNavigationController alloc] initWithRootViewController:lifeVC];
        [self.mm_drawerController setCenterViewController:nav withFullCloseAnimation:YES completion:nil];
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
