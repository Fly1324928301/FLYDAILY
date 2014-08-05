//
//  FLYAboutUsViewController.m
//  FLYDAILY
//
//  Created by fenglianyi on 14-8-4.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYAboutUsViewController.h"

@interface FLYAboutUsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation FLYAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"关于我们";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 10;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
