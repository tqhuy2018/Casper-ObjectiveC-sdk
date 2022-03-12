#import <Foundation/Foundation.h>
#import "GetPeerResult.h"
#import "GetPeerList.h"
@implementation GetPeerResult
-(void) setupWithApiVersion:(NSString*) apiVersion andPeerMap:(NSMutableArray*) peerMapList {
    self.api_version = apiVersion;
    self.PeersMap = [[NSMutableArray alloc] init];
    self.PeersMap = peerMapList;
}
+(GetPeerResult*) fromJsonObjToGetPeerResult:(NSDictionary*) forJSONObject {
    GetPeerList * gpl = [[GetPeerList alloc] init];
    GetPeerResult * gpr = [[GetPeerResult alloc] init];
    gpr = [gpl fromJsonToPeerList : forJSONObject];
    return gpr;
}
@end
