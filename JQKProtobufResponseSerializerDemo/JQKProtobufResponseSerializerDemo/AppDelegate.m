//
//  AppDelegate.m
//  JQKProtobufResponseSerializerDemo
//
//  Created by Xwoder on 2017/8/5.
//  Copyright © 2017年 Xwoder. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] init];
    window.frame = [UIScreen mainScreen].bounds;
    window.rootViewController = [[ViewController alloc] init];
    [window makeKeyAndVisible];
    self.window = window;
    
    return YES;
}

@end
