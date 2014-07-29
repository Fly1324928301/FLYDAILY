//
//  FLYAppDelegate.m
//  DAILYSample
//
//  Created by fenglianyi on 14-7-21.
//  Copyright (c) 2014年 冯廉义. All rights reserved.
//

#import "FLYAppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "FLYMainViewController.h"
#import "FLYLeftViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "MMNavigationController.h"



@interface FLYAppDelegate ()
@property (nonatomic,strong) MMDrawerController * drawerController;

@end


@implementation FLYAppDelegate


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    FLYMainViewController *mainVC = [[FLYMainViewController alloc]init];
    FLYLeftViewController *leftVC = [[FLYLeftViewController alloc]init];
    
    UINavigationController *navigationController = [[MMNavigationController alloc]initWithRootViewController:mainVC];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    UINavigationController *leftNavigationController = [[MMNavigationController alloc] initWithRootViewController:leftVC];
    
    [leftNavigationController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:navigationController leftDrawerViewController:leftNavigationController];
    
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:180.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
//                                          green:173.0/255.0
//                                           blue:234.0/255.0
//                                          alpha:1.0];
//    [self.window setTintColor:tintColor];
    
    [self.window setRootViewController:self.drawerController];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    

    
    
    return YES;
}



- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    
    
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"MMExampleCenterNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
