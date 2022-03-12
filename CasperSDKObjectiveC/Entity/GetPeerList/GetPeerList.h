#ifndef GetPeerList_h
#define GetPeerList_h
#import "GetPeerResult.h"
/**Class for get peer list, wrapped in GetPeerResult class
 This class parse the Json string respresents the GetPeerResult class, then return back a GetPeerResult as result
 */
@interface GetPeerList:NSObject
-(GetPeerResult*) fromJsonToPeerList:(NSDictionary*) nsData;
@end


#endif 
