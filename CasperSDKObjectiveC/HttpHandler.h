#ifndef HttpHandler_h
#define HttpHandler_h
@interface HttpHandler : NSObject
@property NSString * casperURL;
@property NSString * methodCall;
-(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod;
@end

#endif /* HttpHandler_h */
