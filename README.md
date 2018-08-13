# 基于线程安全的 plist 文件管理类
## 警告如果需要修改代码，一定注意dispatch_semaphore_signal(signal);dispatch_semaphore_wait(signal, overTime);需要平衡。dispatch_semaphore_t GCD 线程锁的知识暂不在这里讨论，有兴趣的朋友网上了解或者Q加2542700177。

### 调用方式
    [[JPlistManager new] nativeConfigOperate:^NSArray<NSString *> *{
        //设置 plist 文件路径
        /**
        返回路径
        如：
        A:{
            B:{
                key:value
            }
        }
        则返回@[@"A",@"B",@"key"]
        */
        
        return @[@"BaseConfig",@"key"];
    } handle:^void(NSMutableDictionary *valueLastDic, id value) {
        NSLog(@"返回结果 dic==%@， value==%@",valueLastDic,value);
        if (valueLastDic != nil && value == nil) {
        NSLog(@"最后一个 key 不存在");
    }
    //如果路径不对：
        A:最后一个路径之前的路径不对，返回是两个参数都是 nil，则最后writeToFile 依然是之前已经存在的 plist 文件，不会改变
        B:如果是最后一个路径不存在，那么返回的valueLastDic为查询路径的上一个dic，那工程里面的 InfoConfig.plist 举例如：@[@"c"]，那么valueLastDic就是整个plist字典，如果：@[@"a",@"aa"],那么valueLastDic就是路径 a 下的字典。 增删改这些字典最后writeToFile是操作过的数据。
    //查询的值所在的字典为空，路径不对
    [valueLastDic setValue:@"--E_key-" forKey:@"E_key"];
    [valueLastDic setValue:@"--E_key-" forKey:@"a_key"];
    [valueLastDic removeObjectForKey:@"key"];
    if (valueLastDic != nil) {//查询到值不为空

    }else{//否则不是查询操作或者键值对不存在为空,或者路径不对

    }
    }]();

    
