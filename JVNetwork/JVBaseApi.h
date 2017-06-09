//
//  JVBaseApi.h
//  JVNetwork
//
//  Created by fengchao on 2017/5/31.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import <ReactiveCocoa.h>
@interface JVBaseApi : NSObject
-(void)request:(void (^)(id x))success;
@property (nonatomic,strong) JSONModel* responseData;
@property (nonatomic,strong) RACSignal* signal;
@end
