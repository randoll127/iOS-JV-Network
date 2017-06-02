//
//  JVHTTPSessionManager.m
//  JVNetwork
//
//  Created by fengchao on 2017/6/1.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "JVHTTPSessionManager.h"

@implementation JVHTTPSessionManager
+ (instancetype)manager{
    static JVHTTPSessionManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AFHTTPSessionManager manager];
    });
    return sharedInstance;
}
@end
