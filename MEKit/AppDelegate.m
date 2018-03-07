//
//  AppDelegate.m
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
     operator0_0 + operator0_1 = 8
          +             +
     operator1_0 - operator1_1 = 6
         ||            ||
         13            8
     operator0_0 + operator1_0 - (operator0_0 + operator0_1) = 13 - 8 =>
     operator1_0 - operator0_1 = 5
     operator0_1 + operator1_1 + (operator1_0 - operator1_1) = 8 + 6 =>
     operator0_1 - operator1_0 = 14
                                =>
     operator1_0 - operator0_1 = 5
     operator0_1 + operator1_0 = 14
     operator0_1 + operator1_0 - (operator1_0 - operator0_1) = 9
     
     operator0_1 = 4.5
     operator1_1 = 9.5
     */
    int length = 2;
    int operators[length][length];
    int results[2][2] = { {8, 6}, {8, 13} };
    double operator0_0 = 0.0;
    double operator0_1 = 0.0;
    double operator1_0 = 0.0;
    double operator1_1 = 0.0;
    
    for (int i = 0; i < length; i++) {
        for (int j = 0; j < length; j++) {
            
        }
    }
    
    
    
    
    
    
    
    return YES;
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
