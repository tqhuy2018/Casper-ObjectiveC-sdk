#import <Foundation/Foundation.h>
#import "GetPeerResult.h"
#import "GetPeerList.h"
#import "ConstValues.h"
#import "HttpHandler.h"
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
+(void) getPeerResultWithJsonParam:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_INFO_GET_PEERS];
}
@end
