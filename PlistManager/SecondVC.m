//
//  SecondVC.m
//  AAAAAA
//
//  Created by 江其 on 2018/8/7.
//  Copyright © 2018年 江其. All rights reserved.
//

#import "SecondVC.h"
#import "JQPlistManager.h"
@interface SecondVC ()
@property(nonatomic, strong)JQPlistManager *c;
@property(atomic, strong) NSLock *lock;
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    _c = [[JQPlistManager alloc]init];
    _lock = [NSLock new];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    for (int i=0; i<9; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            return [self aaa:[NSString stringWithFormat:@"%d",i]];
        });
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-1"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-2"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-3"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-4"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"5"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-6"];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        return [self aaa:@"-7"];
    });
    
//    return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
//    [self.c nativeConfigOperate:^NSArray<NSString *> *{
//
//        return @[@"A",@"B",@"bbb",@"D",@"E",@"E_key"];
//    } handle:^void(NSMutableDictionary *valueLastDic, id value) {
//        NSLog(@"返回结果 dic==%@， value==%@",valueLastDic,value);
//
//        //查询的值所在的字典为空，路径不对
////        NSAssert(valueLastDic != nil, @"路径错误");
////        [valueLastDic setValue:@"+++++" forKey:@"one"];
////        [valueLastDic removeObjectForKey:@"E_key"];
////        if (valueLastDic != nil) {//查询到值不为空
////
////        }else{//否则不是查询操作或者键值对不存在为空,或者路径不对
////
////        }
//    }]();
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [self.c nativeConfigOperate:^NSArray<NSString *> *{
            
            return @[@"cccc"];
        } handle:^void(NSMutableDictionary *valueLastDic, id value) {
            NSLog(@"返回结果 dic==%@， value==%@",valueLastDic,value);
            if (valueLastDic != nil && value == nil) {
                NSLog(@"最后一个 key 不存在");
            }
            //查询的值所在的字典为空，路径不对
            [valueLastDic setValue:@"--E_key-" forKey:@"E_key"];
            [valueLastDic setValue:@"--E_key-" forKey:@"a_key"];
            [valueLastDic removeObjectForKey:@"key"];
            if (valueLastDic != nil) {//查询到值不为空
                
            }else{//否则不是查询操作或者键值对不存在为空,或者路径不对
                
            }
        }]();
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        [self.c nativeConfigOperate:^NSArray<NSString *> *{
            
            return @[@"ccc"];
        } handle:^void(NSMutableDictionary *valueLastDic, id value) {
            NSLog(@"返回结果 dic==%@， value==%@",valueLastDic,value);
            
            //查询的值所在的字典为空，路径不对
            [valueLastDic setValue:@"--E_key-" forKey:@"E_key"];
            [valueLastDic setValue:@"--E_key-" forKey:@"a_key"];
            [valueLastDic removeObjectForKey:@"key"];
            if (valueLastDic != nil) {//查询到值不为空
                
            }else{//否则不是查询操作或者键值对不存在为空,或者路径不对
                
            }
        }]();
    });
    
    /*
     数组越界，字典不存在，value 的情况
     根目录 + ok
     孙目录 改 删除 OK 增OK
     */
}

-(void)aaa:(NSString *)s
{
    return ;
    NSLog(@"lock 测试开始==%@",s);
//    sleep(1);
//    @synchronized(self){
    [self.lock lock];
        NSLog(@"lock 测试==%@",s);
        sleep(1);
//    }
    [self.lock unlock];

    return;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}
- (void)dealloc
{
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
