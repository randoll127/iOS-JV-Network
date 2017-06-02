#import <Foundation/Foundation.h>

@protocol JVRequestProtocol <NSObject>
@required
-(NSString*)requestUrl;
-(Class)responseModel;


-(void)success:(NSURLResponse*) response responseObject:(id)responseObject;
-(void)error:(NSURLResponse*) response responseObject:(id)responseObject error:(NSError*)error;

@optional
-(void)completed:(NSURLResponse*) response responseObject:(id)responseObject error:(NSError*)error;

@end
