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
    @weakify(self)
    self.signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
        @strongify(self)
        [[JVRequestStrategy sharedInstance] request:self completed:^(NSURLResponse *response, id responseObject, NSError *error){
            if (error) {
                [subscriber sendError:error];
            } else {
                NSError* jsonModelError;
                
                if(jsonModelError){
                    [subscriber sendError:jsonModelError];
                }else{
                    
                    [subscriber sendNext:[[[[self class] responseModel] alloc] initWithData:responseObject error:&jsonModelError]];
                    [subscriber sendCompleted];
                }
            }
        }];
        return nil;
    }];
    
//    [self zipWith];
//    [self combineLatest];
}

//
//- (void)concat
//{
//    //创建信号A
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        //发送请求
//        NSLog(@"发送上部分的请求");
//        //发送信号
//        [subscriber sendNext:@"上部分数据"];
//        //发送完毕
//        //加上后就可以上部分发送完毕后发送下半部分信号
//        //[subscriber sendCompleted];
//        return nil;
//    }];
//    
//    //创建信号B
//    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        //发送请求
//        NSLog(@"发送下部分的请求");
//        //发送信号
//        [subscriber sendNext:@"下部分数据"];
//        return nil;
//    }];
//    //创建组合信号
//    //concat:按顺序去连接(组合)
//    //注意:第一个信号必须调用sendCompleted
//    RACSignal *concat = [signalA concat:signalB];
//    //订阅组合信号
//    [concat subscribeNext:^(id x) {
//        //既能拿到A信号的值,又能拿到B信号的值
//        NSLog(@"%@", x);
//    }];
//}
//
//
//- (void)then
//{
//    //创建信号A
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        //发送请求
//        NSLog(@"发送上部分的请求");
//        //发送信号
//        [subscriber sendNext:@"上部分数据"];
//        //发送完毕
//        //加上后就可以上部分发送完毕后发送下半部分信号
//        [subscriber sendCompleted];
//        return nil;
//        
//    }];
//    
//    //创建信号B
//    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        //发送请求
//        NSLog(@"发送下部分的请求");
//        //发送信号
//        [subscriber sendNext:@"下部分数据"];
//        return nil;
//        
//    }];
//    
//    //thenSignal组合信号
//    //then:会忽略掉第一个信号的所有值
//    RACSignal *thenSignal = [signalA then:^RACSignal *{
//        //返回的信号就是需要组合的信号
//        return signalB;
//    }];
//    //订阅信号
//    [thenSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//    /*
//     结果:
//     发送上部分的请求
//     发送下部分的请求
//     下部分数据
//     */
//}
//- (void)combineLatest
//{
//    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"A"];
//        [subscriber sendNext:@"B"];
//        [subscriber sendNext:@"C"];
//        [subscriber sendNext:@"D"];
//        [subscriber sendNext:@"E"];
//        return nil;
//    }];
//    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@"1"];
//        [subscriber sendNext:@"2"];
//        [subscriber sendNext:@"3"];
//        [subscriber sendNext:@"4"];
//        [subscriber sendNext:@"5"];
//        return nil;
//    }];
//    //把两个信号组合成一个信号
//    RACSignal *combineSignal = [signalA combineLatestWith:signalB];
//    RACSignal *combineSignal2 = [signalA zipWith:signalB];
//    
//    //订阅组合信号
//    [combineSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    [combineSignal2 subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    
//}
//
//- (void)zipWith
//{
//    //创建信号A
//    RACSubject *signalA = [RACSubject subject];
//    //创建信号B
//    RACSubject *signalB = [RACSubject subject];
//    //压缩成一个信号
//    //当一个界面多个请求时,要等所有的请求都完成才能更新UI
//    //打印顺序跟组合顺序有关,跟发送顺序无关
//    RACSignal *zipSignal = [signalA zipWith:signalB];
//    //订阅信号
//    [zipSignal subscribeNext:^(id x) {
//        NSLog(@"%@", x);
//    }];
//    //发送信号
//    [signalA sendNext:@"HMJ"];
//    [signalB sendNext:@"GQ"];
//    /*
//     结果
//     <RACTuple: 0x7ffd8351f120>
//     (
//     HMJ,
//     GQ
//     )
//     */
//}

-(void)request:(void (^)(id x))success{
    @weakify(self)
    [self.signal subscribeNext:^(id x) {
        success(x);
    }];
}

DEALLOC_LOG
@end
