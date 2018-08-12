//
//  JQPlistManager.m
//  AAAAAA
//
//  Created by 江其 on 2018/8/7.
//  Copyright © 2018年 江其. All rights reserved.
//

#import "JQPlistManager.h"


///block描述
#define WeakObj(o) __weak typeof(o) o##_W = o;
///block描述
#define StrongObj(o) __strong typeof(o) o##S = o;

@interface JQPlistManager()
{
    ///GCD 线程锁
    dispatch_semaphore_t signal;
    ///超时时间
    dispatch_time_t overTime ;

}

@end

@implementation JQPlistManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        signal = dispatch_semaphore_create(1);
        
        overTime = dispatch_time(DISPATCH_TIME_NOW, 300 * NSEC_PER_SEC);
    }
    return self;
}

#pragma mark - --操作用户基本配置

-(void(^)(void))nativeConfigOperate:(NSArray<NSString *>*(^)(void))pathBlock handle:(void(^)(NSMutableDictionary *lastDic, id value))handleBlock
{
    NSAssert(pathBlock != nil, @"路径不能为空");

    dispatch_semaphore_wait(signal, overTime);
    
    ///沙盒 plist 路径，不要放在工程目录下，没有权限去修改。
    NSString *infoplistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"config/InfoConfig.plist"];
    
    NSArray <NSString *>* keypathArr = pathBlock();
    
    
    if (keypathArr.count == 0) {

        return ^{ };
    }
    
    //plist 对象
    NSMutableDictionary *bigDic = [NSMutableDictionary dictionaryWithContentsOfFile:infoplistPath];
    NSLog(@"lastDic 初始化===%@",bigDic);
    //最后一个 key 所在的 dictionary，暴露给其他调用类，可以用来增删改查操作
    NSMutableDictionary *lastDic = bigDic;
    id lastData = nil;
    
    for (int i=0; i<keypathArr.count; i++) {
        if (i==keypathArr.count-1) {
            
            //根据keypathArr路径查询最后一个 key 对应的数据
            lastData = lastDic[keypathArr[i]];

            break;
        }
        lastDic = lastDic[keypathArr[i]];
    }
    
    
    
    WeakObj(keypathArr);
    WeakObj(infoplistPath);
    WeakObj(lastDic);
    WeakObj(bigDic);
        
    void(^handleFinishBlock)(void) = ^{
        
        /*
         optimize：
         应该采用链表结构设计，
         */
        #warning 最结束处一定要调用线程解锁
        //在返回 block 的时候一定要解锁，否则会阻塞线程
        dispatch_semaphore_wait(signal, overTime);
        
        //用 strong 修饰防止weak 修饰的对象释放，而 block 对其内部创建的对象并不会再一次的强引用
        StrongObj(keypathArr_W);
        StrongObj(infoplistPath_W);
        StrongObj(lastDic_W);
        StrongObj(bigDic_W);
        
     
        if (keypathArr_WS.count == 1) {//第一层
            bigDic_WS = lastDic_WS;
        }else {//第二层及以上
            
            NSMutableDictionary *tempDic = bigDic_WS;
            NSInteger count = keypathArr_WS.count-1;
            
            //for 遍历，后期我将尝试用节点的方式来设计算法
            for (int i=0; i<count; i++) {
                
                if (i == count-1) {
                    if (i == 0) {
         
                        //最终遍历会执行到这里结束
                        [bigDic_WS setValue:lastDic_WS forKey:keypathArr_WS[i]];

                        break;
                    }
                    [tempDic setValue:lastDic_WS forKey:keypathArr_WS[i]];
                    
                    count = i;
                    i = -1;
                    lastDic_WS = tempDic;

                    tempDic = bigDic_WS;
                    
                    continue;
                }
                
                tempDic = tempDic[keypathArr_WS[i]];

            }
        }
        /*
         路径数组中包含不存在的路径
         1、最后一个 key 不存在，则依然会返回正确的 lastDic ，只是返回的 value 为空而已。
         2、之前的 key 不存在，那么存入的依然是之前本地已经存在的数据，不会改变
         */
        NSLog(@"bigDic_WSKVC 赋值后===%@",bigDic_WS);
        BOOL storage = [bigDic_WS writeToFile:infoplistPath_WS atomically:YES];
        NSLog(@"储存==%@---%@",storage?@"成功":@"失败",keypathArr);
        
        #warning 最结束处一定要调用线程解锁
        //线程解锁
        dispatch_semaphore_signal(signal);

    };
    
    handleBlock(lastDic, lastDic[keypathArr[keypathArr.count-1]]);
    dispatch_semaphore_signal(signal);
    return handleFinishBlock;
}

@end
