//
//  AppDelegate.m
//  workinghopshack
//
//  Created by Blake Butterworth on 2/21/15.
//  Copyright (c) 2015 Blake Butterworth. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterTableViewController.h"
//#import "GetLocationViewController.h"
#import "FavoritesTableViewController.h"
#import "DiscoverViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    _myGreen=[[UIColor alloc] initWithRed:0.376 green:0.729 blue:0.318 alpha:1.000];
    _myBlue=[[UIColor alloc] initWithRed:0.11 green:0.27 blue:0.53 alpha:1.0];
    
    MasterTableViewController *masterTVC=[[MasterTableViewController alloc]init];
    UINavigationController *masterNC =[[UINavigationController alloc]initWithRootViewController:masterTVC];
       masterNC.navigationBar.barTintColor=_myGreen;
    DiscoverViewController *discoverVC=[[DiscoverViewController alloc]init];
    UINavigationController *discoverNC=[[UINavigationController alloc]initWithRootViewController:discoverVC];
    discoverNC.navigationBar.barTintColor=_myGreen;
    FavoritesTableViewController *favTVC=[[FavoritesTableViewController alloc]init];
    UINavigationController *favNC=[[UINavigationController alloc]initWithRootViewController:favTVC];
    favNC.navigationBar.barTintColor=_myGreen;
    
    UITabBarController *tabBarController =[[UITabBarController alloc]init];
    [tabBarController setViewControllers:@[masterNC,favNC,discoverNC]];
     tabBarController.tabBar.barTintColor =_myBlue;
    tabBarController.tabBar.tintColor=[UIColor whiteColor];
    self.window.rootViewController=tabBarController;
   

   
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {

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
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
