#import "JVRequestGetImpl.h"
#import "JVRequestProtocol.h"
#import "JVHTTPSessionManager.h"
#import <ReactiveCocoa.h>
@interface JVRequestGetImpl(){
    JVHTTPSessionManager* mUrlSessionManager;
    AFSecurityPolicy* mSecurityPolicy;
}
@end
@implementation JVRequestGetImpl
-(instancetype)init{
    self = [super init];
    if(self){
        mSecurityPolicy =  [self doInitSecurityPolicy];
        
        mUrlSessionManager = [JVHTTPSessionManager manager];
        [mUrlSessionManager setSecurityPolicy:mSecurityPolicy];
        
        AFHTTPRequestSerializer *requestSer = [AFHTTPRequestSerializer new];
        [requestSer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        NSMutableSet* set = [[NSMutableSet alloc]initWithSet:mUrlSessionManager.responseSerializer.acceptableContentTypes];
        [set addObject:@"text/html"];
        mUrlSessionManager.responseSerializer.acceptableContentTypes = set;
                [mUrlSessionManager setRequestSerializer:requestSer];
        
        AFHTTPResponseSerializer* responseSer = [AFHTTPResponseSerializer serializer];
        [mUrlSessionManager setResponseSerializer:responseSer];
        
        
    }
    return self;
}

- (AFSecurityPolicy*)doInitSecurityPolicy{
    AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [policy setAllowInvalidCertificates:YES];
    [policy setValidatesDomainName:NO];
    
    //证书校验方式
    //    mSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //    [mSecurityPolicy setAllowInvalidCertificates:NO];
    //    [mSecurityPolicy setValidatesDomainName:YES];
    return policy;
}

-(BOOL)assemblingFromRequestApi:(id)requestApi{
    if([requestApi conformsToProtocol:@protocol(JVRequestProtocol)])
        return YES;
    else
        return NO;
}

-(void)request:(id<JVRequestProtocol>)requestApi completed:(void (^)(NSURLResponse *, id, NSError *))completeBlock{
    NSError* serializationError;
    NSMutableURLRequest *request = [mUrlSessionManager.requestSerializer requestWithMethod:@"GET" URLString:[requestApi requestUrl] parameters:nil error:&serializationError];
    NSURLSessionDataTask *dataTask = [mUrlSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        completeBlock(response,responseObject,error);
    }];
    [dataTask resume];
    
}
//-(void)request:(id<JVRequestProtocol>)requestApi{
//    DLog(@"%@",requestApi);
//
//    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:[requestApi requestUrl]]];
//    NSError* serializationError;
//    NSMutableURLRequest *request = [mUrlSessionManager.requestSerializer requestWithMethod:@"GET" URLString:@"https://www.baidu.com" parameters:nil error:&serializationError];
//
//    NSURLSessionDataTask *dataTask = [mUrlSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            DLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//    }];
//    [dataTask resume];
//}






DEALLOC_LOG
@end
