#import <Foundation/Foundation.h>
#import "JVBaseApi.h"
#import "JVRequestProtocol.h"
@protocol JVRequestStrategyProtocol <NSObject>
@required
-(void)request:(id<JVRequestProtocol>)requestApi;
-(BOOL)assemblingFromRequestApi:(id<JVRequestProtocol>)requestApi;

@end


@interface JVRequestStrategy : NSObject
+ (JVRequestStrategy *)sharedInstance;
-(void)request:(id<JVRequestProtocol>)api;
@end
