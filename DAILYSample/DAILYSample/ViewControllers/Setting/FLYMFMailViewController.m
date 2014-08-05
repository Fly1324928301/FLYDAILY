//
//  FLYMFMailViewController.m
//  FLYDAILY
//
//  Created by fenglianyi on 14-8-5.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYMFMailViewController.h"
#import <MessageUI/MessageUI.h>

@interface FLYMFMailViewController ()<MFMailComposeViewControllerDelegate>
{
    
    UITextView *_textView;
    
}

@end

@implementation FLYMFMailViewController

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
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(rightBarAction)];
    barbutton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = barbutton;
    
    [self loadTextView];
    
}







// loadtextView
- (void)loadTextView
{
    
    _textView = [[UITextView alloc] initWithFrame:Rect(0, 0, 320, self.view.frame.size.height - 280)];
    _textView.textColor = [UIColor blackColor];
    [self.view addSubview:_textView];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [_textView becomeFirstResponder];
    
}

#pragma mark - UIBarButtonItem
- (void)rightBarAction
{
    
    
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        [self alertWithMessage:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"];
        return;
    }
    if (![mailClass canSendMail]) {
        [self alertWithMessage:@"用户没有设置邮件账户"];
        return;
    }
    
    
    
    
    
    //  判断是否可以发送Email
    BOOL canSendMail = [MFMailComposeViewController canSendMail];
    if (canSendMail) {
        //  创建邮件视图控制器
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        //  设置代理
        picker.mailComposeDelegate = self;
        //设置主题
        [picker setSubject:@"意见反馈"];
        
        //  设置发送对象
        [picker setToRecipients:[NSArray arrayWithObjects:@"1324928301@qq.com", nil]];
        
        //  设置抄送对象
        [picker setCcRecipients:[NSArray arrayWithObjects:@"1324928301@qq.com", nil]];
        
        //  设置发送内容
        NSString *messStr = [NSString stringWithFormat:@"<font color='red'>eMail</font>%@",_textView.text];
        [picker setMessageBody:messStr isHTML:YES];
        
        
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}



- (void)alertWithMessage:(NSString *)message
{
    
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [aler show];
    
    
}




#pragma mark - UITextViewDelegate Methods
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textView.text = @"";
    _textView.textColor = [UIColor blackColor];
    return YES;
}

#pragma mark - MFMailDelegate Methods
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *resultStr;
    switch (result) {
        case MFMailComposeResultFailed:
            resultStr = @"发送失败";
            break;
        case MFMailComposeResultSaved:
            resultStr = @"保存";
            break;
        case MFMailComposeResultSent:
            resultStr = @"发送成功";
            _textView.text = @"";
            break;
        case MFMailComposeResultCancelled:
            resultStr = @"取消发送";
            break;
        default:
            break;
    }
    
    [self alertWithMessage:resultStr];
   
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
