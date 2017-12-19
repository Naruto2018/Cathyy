//
//  AppDelegate.m
//  Cathyy
//
//  Created by 鸣人 on 2017/12/18.
//  Copyright © 2017年 NarutoMac. All rights reserved.
//

#import "AppDelegate.h"
#import "VCHome.h"
#import "VCBbs.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建窗口对象
    [NSThread sleepForTimeInterval:3.0]; //设置启动页面时间,系统默认1秒
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    VCHome* vcHome = [[VCHome alloc] init];
    VCBbs* vcBbs = [[VCBbs alloc] init];
    
    //设置控制器标题
    vcHome.title = @"主页";
    vcBbs.title = @"论坛";
    
    UINavigationController* navHome = [[UINavigationController alloc] initWithRootViewController:vcHome];
    UINavigationController* navBbs = [[UINavigationController alloc] initWithRootViewController:vcBbs];
    
    //创建控制器数组
    NSArray* vcArry = [NSArray arrayWithObjects:navHome, navBbs,nil];
    //创建分栏控制器
    UITabBarController* tbcVc = [[UITabBarController alloc] init];
    tbcVc.viewControllers = vcArry;
    
    tbcVc.selectedIndex = 0;
    if (tbcVc.selectedViewController == navHome) {
        NSLog(@"选中0");
    }
    tbcVc.tabBar.translucent = NO;
    
    self.window.rootViewController = tbcVc;
     self.window.backgroundColor = [UIColor whiteColor];
    //设置主窗口并显示
    [self.window makeKeyAndVisible];
    
    [self _enteranceControl:launchOptions];
    return YES;
}

-(void)_enteranceControl:(NSDictionary *)launchOptions{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
