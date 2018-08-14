//
//  SecondVC.m
//  AAAAAA
//
//  Created by  on 2018/8/7.
//  Copyright © 2018年 . All rights reserved.
//

#import "SecondVC.h"
#import "JPlistManager.h"
@interface SecondVC ()
//@property(nonatomic, strong)JPlistManager *manager;

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
//    _manager = [[JPlistManager alloc]init];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"开始");
        
        [JPlistManager.shareInstance nativeConfigOperate:^NSArray<NSString *> *{
            
            /**
             返回路径
             如：
             A:{
                 B:{
                     key:value
                 }
            }
             */
            
            return @[@"BaseConfig",@"key"];
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
        NSLog(@"结束");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"开始---");
        [JPlistManager.shareInstance nativeConfigOperate:^NSArray<NSString *> *{
            
            return @[@"UserInfo"];
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
        NSLog(@"结束---");
    });
    
   
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
