//
//  AppDelegate.m
//  SYDynamicTextDemo
//
//  Created by Saucheong Ye on 9/16/15.
//  Copyright (c) 2015 sauchye.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //设置状态栏 启动页面不显示状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //处理为白色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
  

    UIViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    nav.navigationBar.translucent = NO;
    
    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:180/255.0f blue:234/255.0f alpha:1]];
    //返回按钮颜色设置
    nav.navigationBar.tintColor = [UIColor whiteColor];
    
    //navTitle字体颜色设置
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    
    
    return YES;
}

@end
