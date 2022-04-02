#ifndef HttpHandler_h
#define HttpHandler_h
/**HttpHandler class - Class built for handle POST method of all RPC call
 */
@interface HttpHandler : NSObject
///The URL of the POST method that the request will point to , can be "https://node-clarity-testnet.make.services/rpc" for test net
///or  "https://node-clarity-mainnet.make.services/rpc" for main net or just your local host
+ (NSString *) casperURL;
///Function where all the RPC call is handled, with the send of parameter to the POST method and the handle of JSON data back from the server
+(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod;
@end

#endif 
