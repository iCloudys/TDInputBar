//
//  AppDelegate.m
//  TDInputBarDemo
//
//  Created by Mac on 2017/11/28.
//  Copyright © 2017年 RUIPENG. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController* rootViewController = [[ViewController alloc] init];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];

    return YES;
}

@end
