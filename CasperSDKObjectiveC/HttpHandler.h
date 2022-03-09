#ifndef HttpHandler_h
#define HttpHandler_h
@interface HttpHandler : NSObject
@property NSString * url;
@property NSString * methodCall;
-(void) handleRequestWithParam:(NSString*) params;
@end

#endif /* HttpHandler_h */
