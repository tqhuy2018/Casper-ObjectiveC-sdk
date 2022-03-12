#ifndef GetPeerResult_h
#define GetPeerResult_h

@interface GetPeerResult:NSObject
@property NSString* api_version;
@property NSMutableArray * PeersMap;
-(void) setupWithApiVersion:(NSString*) apiVersion andPeerMap:(NSMutableArray*) peerMapList;
+(GetPeerResult*) fromJsonObjToGetPeerResult:(NSDictionary*) jsonDict;
@end

#endif 
