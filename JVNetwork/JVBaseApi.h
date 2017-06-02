//
//  JVBaseApi.h
//  JVNetwork
//
//  Created by fengchao on 2017/5/31.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface JVBaseApi : NSObject
-(void)request;
@property (nonatomic,strong) JSONModel* responseData;
@end
