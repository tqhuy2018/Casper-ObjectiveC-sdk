#ifndef GetPeerResult_h
#define GetPeerResult_h
/**Class for  GetPeerResult
 This class contains all the information for a result taken back from info_get_peers RPC call
 */
#import <Foundation/Foundation.h>
@interface GetPeerResult:NSObject
@property NSString* api_version;
///List of PeerEntry
@property NSMutableArray * PeersMap;
///This function generate the values of GetPeerResult object based on the apiVersion and list of PeerEntry
-(void) setupWithApiVersion:(NSString*) apiVersion andPeerMap:(NSMutableArray*) peerMapList;
///This is class function to get the GetPeerResult from a dictionary input, which is part of the JSON sent back from the info_get_peers RPC call
+(GetPeerResult*) fromJsonObjToGetPeerResult:(NSDictionary*) jsonDict;
///This is class function call the RPC method through the HttpHandler class and get the Json data back as input for the fromJsonObjToGetPeerResult function call
+(void) getPeerResultWithJsonParam:(NSString*) jsonString;
@end

#endif 
