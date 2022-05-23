#ifndef GetPeerList_h
#define GetPeerList_h
#import "GetPeerResult.h"
/**Class for get peer list, wrapped in GetPeerResult class
 This class parse the Json string respresents the GetPeerResult class, then return back a GetPeerResult as result
 */
@interface GetPeerList:NSObject
/**This function parse the NSDictionary object to GetPeerResult object
 When send POST request in info_get_peers RPC call, the result is sent back as Json data, in type of key-value pairs.
 This function parse the JSON to get the GetPeerResult object
 */
-(GetPeerResult*) fromJsonToGetPeerResult:(NSDictionary*) fromDict;
/**This function parse the NSDictionary object to PeerEntry List
 The NSDictionary object stored in fromDict input is also a part of the JSON back from the  info_get_peers RPC call
 */
+(NSMutableArray*) fromJsonToPeerMap:(NSDictionary*) fromDict;
@end


#endif 
