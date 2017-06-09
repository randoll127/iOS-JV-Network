#import "JVRequestStrategy.h"
#import "JVBaseApi.h"

@interface JVRequestStrategy(){
    NSArray* mStrategyArr;
}

@end

@implementation JVRequestStrategy
+ (JVRequestStrategy *)sharedInstance{
    static JVRequestStrategy *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    if(self){
        mStrategyArr = [[NSArray alloc] initWithContentsOfFile:FRAMEWORK_BUNDLE_WITH_FILENAME(@"requestConfig.plist")];
    }
    return self;
}

-(void)request:(id<JVRequestProtocol>)api completed:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completeBlock{
    for(NSDictionary* __strategy in mStrategyArr){
        Class __cls = NSClassFromString(__strategy[@"name"]);
        id<JVRequestStrategyProtocol> __instance = [__cls new];
        if([__instance assemblingFromRequestApi:api]){
            [__instance request:api completed:completeBlock];
            break;
        }
    }
}



@end
