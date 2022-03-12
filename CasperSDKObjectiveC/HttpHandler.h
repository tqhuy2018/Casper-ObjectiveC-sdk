#ifndef HttpHandler_h
#define HttpHandler_h
@interface HttpHandler : NSObject
+ (NSString *) casperURL;
+ (NSString *) methodCall;
+(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod;
@end

#endif 
