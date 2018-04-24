//
//  AppDelegate.m
//  qsd
//
//  Created by mc on 2018/4/20.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchIntroductionView.h"
#import "MainViewController.h"
#import "ZJVc3Controller.h"  // 滚动页面
#import "NetworkManager.h"
#import "common.h"
#import "AppStartConfigModel.h"
#import "MJExtension.h"
#import "AdViewController.h"
#import "common.h"
#import "UIColor+Hex.h"
#import "XHNavigationController.h"
@interface AppDelegate ()
@property (nonatomic, strong) NSMutableArray *dataArray; // 当前页面数据类

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    // 设置整个页面的导航色和文字风格
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#FE5722"]];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:18.0], NSFontAttributeName,nil]];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

//     AdViewController *adVC = [[AdViewController alloc] init];
//     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:adVC];
//     self.window.rootViewController = nav;

    ZJVc3Controller *main = [[ZJVc3Controller alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewController:) name:@"changeRootViewController" object:nil];


    #if 1
    [LaunchIntroductionView sharedWithImages:@[@"launch1",@"launch2",@"launch3"] buttonImage:nil buttonFrame:CGRectMake(kScreen_width/2 - 150, kScreen_height - 190, 300, 150)];
    //    [LaunchIntroductionView sharedWithImages:@[@"launch1",@"launch2",@"launch3"]];
    #elif 0
    [LaunchIntroductionView sharedWithImages:@[@"launch1",@"launch2",@"launch3"] buttonImage:@"searchBtn" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    #elif 0
    LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[@"launch0.jpg",@"launch1.jpg",@"launch2.jpg",@"launch3"] buttonImage:nil buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    launch.currentColor = [UIColor redColor];
    launch.nomalColor = [UIColor greenColor];
    #else
    //只有在存在该storyboard时才调用该方法，否则会引起crash
    [LaunchIntroductionView sharedWithStoryboard:@"Main" images:@[@"launch0.jpg",@"launch1.jpg",@"launch2.jpg",@"launch3"] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    #endif
    

    return YES;
}
- (void)changeRootViewController:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"fromAdVC"]) // 改变根式图
    {
        ZJVc3Controller *main = [[ZJVc3Controller alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
        self.window.rootViewController = nav;
    }else{
        
    }
}

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
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
