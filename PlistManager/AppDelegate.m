//
//  AppDelegate.m
//  AAAAAA
//
//  Created by  on 2018/8/7.
//  Copyright © 2018年 . All rights reserved.
//

#import "AppDelegate.h"
#import <AvoidCrash/AvoidCrash.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSLog(@"%@",NSHomeDirectory());
    
    // 数据库路径-沙盒路径
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"config/InfoConfig.plist"];
    
    // 复制本地数据到沙盒中
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 获得数据库文件在工程中的路径——源路径。
    NSString *sourcesPath = [[NSBundle mainBundle] pathForResource:@"InfoConfig" ofType:@"plist"];
    [fileManager removeItemAtPath:fileName error:nil];
    if (![fileManager fileExistsAtPath:fileName]) {
        
        NSError *error ;
        
        NSString *dirPath = [fileName stringByDeletingLastPathComponent];
        
        BOOL isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"creat File Failed. errorInfo:%@",error);
        }
        if (isSuccess) {
            if ([fileManager moveItemAtPath:sourcesPath toPath:fileName error:&error]){
                
                NSLog(@"数据库移动成功");
            } else {
                NSLog(@"数据库移动失败:%@",error);
            }
        }
    }
    [AvoidCrash becomeEffective];
    
    //监听通知:AvoidCrashNotification, 获取AvoidCrash捕获的崩溃日志的详细信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
    return YES;
}

#pragma mark -AvoidCrashNotification
- (void)dealwithCrashMessage:(NSNotification *)note {
    //注意:所有的信息都在userInfo中
    //你可以在这里收集相应的崩溃信息进行相应的处理(比如传到自己服务器)
    
    NSDictionary *info = note.userInfo;
    NSString *errorReason = [NSString stringWithFormat:@"【ErrorReason】%@========【ErrorPlace】%@========【DefaultToDo】%@========【ErrorName】%@", info[@"errorReason"], info[@"errorPlace"], info[@"defaultToDo"], info[@"errorName"]];
    NSArray *callStack = info[@"callStackSymbols"];
    
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

