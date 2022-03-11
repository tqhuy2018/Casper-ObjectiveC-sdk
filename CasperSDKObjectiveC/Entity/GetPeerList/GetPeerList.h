#ifndef GetPeerList_h
#define GetPeerList_h
#import "GetPeerResult.h"
/**Class for get peer list, wrapped in GetPeerResult class
 This class parse the Json string respresents the GetPeerResult class, then return back a GetPeerResult as result
 */
@interface GetPeerList:NSObject
/**
 @param [nsData as NSDictionary] [ The Json string respresents the GetPeerResult class]
 @return [GetPeerResult which contains the api_version and peer list]
 */
-(GetPeerResult*) fromJsonToPeerList:(NSDictionary*) nsData;
@end


#endif 
