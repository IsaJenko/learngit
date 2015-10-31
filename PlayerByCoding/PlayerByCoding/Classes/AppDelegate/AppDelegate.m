//
//  AppDelegate.m
//  PlayerByCoding
//
//  Created by LakesMac on 15/10/10.
//  Copyright © 2015年 Lake. All rights reserved.
//

#import "AppDelegate.h"
#import "MusicListTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MusicListTableViewController *musicVC = [[MusicListTableViewController alloc]init];
    UINavigationController *rootNC = [[UINavigationController alloc]initWithRootViewController:musicVC];
//    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    
    [UINavigationBar appearance].translucent = NO;
    
    [UINavigationBar appearance].barTintColor = kTintColorGreen_2;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    self.window.rootViewController = rootNC;
    _window.backgroundColor = [UIColor blackColor];
    [_window makeKeyAndVisible];
    
    
    [_window addSubview:[OnPlayingFootView shareOnPlayingFootView]];
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
