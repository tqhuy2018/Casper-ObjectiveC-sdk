#ifndef GetPeerRPC_h
#define GetPeerRPC_h
#import <Foundation/Foundation.h>
@interface GetPeerRPC:NSObject
@property NSString * casperURL;
@property NSString * callID;
/// This dictionary object hold the value of the GetPeerResult when call the RPC, it is used when you call the RPC from other package or other project.
@property NSMutableDictionary * valueDict;
///This is class function call the RPC method through the HttpHandler class and get the Json data back as input for the fromJsonObjToGetPeerResult function call
-(void) initializeWithRPCURL:(NSString*) url;
-(void) getPeerResultWithJsonParam:(NSString*) jsonString;
-(void) getPeerResultWithJsonParam2:(NSString*) jsonString andCallID:(NSString*) callID;
@end
#endif
