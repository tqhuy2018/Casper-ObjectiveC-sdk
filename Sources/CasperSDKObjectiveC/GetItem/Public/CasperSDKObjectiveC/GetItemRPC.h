#ifndef GetItemRPC_h
#define GetItemRPC_h
#import <Foundation/Foundation.h>
@interface GetItemRPC:NSObject
@property NSString * casperURL;
@property NSString * callID;
// This value is to check when the result of the RPC method from the POST method is ready, is valid or in error state
@property NSMutableDictionary * rpcCallGotResult;
/// This dictionary object hold the value of the GetItemResult when call the RPC, it is used when you call the RPC from other package or other project.
@property NSMutableDictionary * valueDict;
///This is class function call the RPC method through the HttpHandler class and get the Json data back as input for the fromJsonObjToGetPeerResult function call
-(void) initializeWithRPCURL:(NSString*) url;
-(void) getItemResultWithJsonParam:(NSString*) jsonString;
-(void) getItemResultWithJsonParam2:(NSString*) jsonString andCallID:(NSString*) callID;
@end
#endif
