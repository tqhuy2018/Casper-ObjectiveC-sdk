#ifndef HttpHandler_h
#define HttpHandler_h
@interface HttpHandler : NSObject
+ (NSString *) casperURL;
+(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod;
@end

#endif 