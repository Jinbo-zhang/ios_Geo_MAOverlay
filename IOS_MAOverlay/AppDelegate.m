//
//  AppDelegate.m
//  IOS_MAOverlay
//
//  Created by zhang jb on 2021/7/6.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController=[[ViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    return YES;
}




@end
