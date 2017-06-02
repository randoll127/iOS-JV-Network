//
//  JVNetwork.h
//  JVNetwork
//
//  Created by fengchao on 2017/5/27.
//  Copyright © 2017年 FC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JVDownloadFiles.h"
#import "JVRequestProtocol.h"
#import "JVBaseApi.h"


@interface JVNetwork : NSObject
+ (JVNetwork *)sharedInstance;
-(void)request;
@end
