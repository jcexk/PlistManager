//
//  JQPlistManager.h
//  AAAAAA
//
//  Created by 江其 on 2018/8/7.
//  Copyright © 2018年 江其. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JQPlistManager : NSObject
-(void(^)(void))nativeConfigOperate:(NSArray<NSString *>*(^)(void))pathBlock handle:(void(^)(NSMutableDictionary *lastDic, id value))handleBlock;
@end
