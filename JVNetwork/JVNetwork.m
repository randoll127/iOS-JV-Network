//
//  JVNetwork.m
//  JVNetwork
//
//  Created by fengchao on 2017/5/27.
//  Copyright © 2017年 FC. All rights reserved.
//

#import "JVNetwork.h"
#import <AFNetworking.h>
#import "AFURLResponseSerialization.h"
@implementation JVNetwork{
    AFHTTPSessionManager* mUrlSessionManager;
    AFSecurityPolicy* mSecurityPolicy;
}

+ (JVNetwork *)sharedInstance{
    static JVNetwork *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



- (instancetype)init{
    self = [super init];
    if (self) {
        mSecurityPolicy =  [self doInitSecurityPolicy];
        
        mUrlSessionManager = [AFHTTPSessionManager manager];
        [mUrlSessionManager setSecurityPolicy:mSecurityPolicy];
        
        
        AFHTTPRequestSerializer *requestSer = [AFHTTPRequestSerializer new];
        mUrlSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [mUrlSessionManager setRequestSerializer:requestSer];
        
        AFHTTPResponseSerializer* responseSer = [AFHTTPResponseSerializer serializer];
        [mUrlSessionManager setResponseSerializer:responseSer];
        
        //        _downloadSessionManager = [AFHTTPSessionManager manager];//???
        // 初始化文件上传manager
        //        _uploadSessionManager = [AFHTTPSessionManager manager];///???
        // 初始化图片下载器
        //        _imageDownloader = [AFImageDownloader defaultInstance];///????
        //        if ([self hasBackDoor]) {
        //        }else{
        //
        //        }
        
        //        AFHTTPResponseSerializer *responseSer = [AFHTTPResponseSerializer new];
        //        mSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //        [mSecurityPolicy setAllowInvalidCertificates:YES];
        //        [mSecurityPolicy setValidatesDomainName:NO];
        //
        //        [_urlSessionManager setResponseSerializer:responseSer];
        //
        //        // 初始化文件下载manager
        //        _downloadSessionManager = [AFHTTPSessionManager manager];
        //        // 初始化文件上传manager
        //        _uploadSessionManager = [AFHTTPSessionManager manager];
        //        // 初始化图片下载器
        //        _imageDownloader = [AFImageDownloader defaultInstance];
        //        [_imageDownloader.sessionManager setSecurityPolicy:_securityPolicy];
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

-(void)request{
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSError* serializationError;
       NSMutableURLRequest *request = [mUrlSessionManager.requestSerializer requestWithMethod:@"GET" URLString:@"https://www.baidu.com" parameters:nil error:&serializationError];
    
    NSURLSessionDataTask *dataTask = [mUrlSessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            DLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

-(void)downloadFile{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://static.lufaxcdn.com/home/index/images/85622264e1.close-hover.png"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}



@end
