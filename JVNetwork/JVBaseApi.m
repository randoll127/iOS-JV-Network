//
//  JVBaseApi.m
//  JVNetwork
//
//  Created by fengchao on 2017/5/31.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "JVBaseApi.h"
#import "JVRequestStrategy.h"
#import "JVRequestGetImpl.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

@interface JVBaseApi() <JVRequestProtocol>
@end

@implementation JVBaseApi{
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self buildRequest];
    }
    return self;
}

-(void)buildRequest{
    
}



-(void)request{
    [[JVRequestStrategy sharedInstance] request:self];
}
@end
