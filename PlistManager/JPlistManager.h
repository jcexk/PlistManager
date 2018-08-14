//
//  JPlistManager.h
//  AAAAAA
//
//  Created by  on 2018/8/7.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPlistManager : NSObject

+(instancetype)alloc __attribute__((unavailable("call shareInstance instead")));
///禁止 new
+(instancetype) new __attribute__((unavailable("call shareInstance instead")));

@property (class, readonly, strong) JPlistManager *shareInstance;

/**
 操作plist
 
 @param pathBlock  设置路径
 @param handleBlock 数据操作
 @return 这个闭包是用来存储更新到本地，如果这是查询不需要更新本地，可以不调用这个返回值
 */
-(void(^)(void))nativeConfigOperate:(NSArray<NSString *>*(^)(void))pathBlock handle:(void(^)(NSMutableDictionary *valueLastDic, id value))handleBlock;
@end

