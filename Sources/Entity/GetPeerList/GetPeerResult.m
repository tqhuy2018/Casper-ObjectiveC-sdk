#import <Foundation/Foundation.h>
#import "GetPeerResult.h"
#import "GetPeerList.h"
#import "ConstValues.h"
#import "HttpHandler.h"
/**Class for  GetPeerResult
 This class contains all the information for a result taken back from info_get_peers RPC call
 */
@implementation GetPeerResult
///This function generate the values of GetPeerResult object based on the apiVersion and list of PeerEntry
-(void) setupWithApiVersion:(NSString*) apiVersion andPeerMap:(NSMutableArray*) peerMapList {
    self.api_version = apiVersion;
    self.PeersMap = [[NSMutableArray alloc] init];
    self.PeersMap = peerMapList;
}
///This is class function to get the GetPeerResult from a dictionary input, which is part of the JSON sent back from the info_get_peers RPC call
+(GetPeerResult*) fromJsonObjToGetPeerResult:(NSDictionary*) forJSONObject {
    GetPeerList * gpl = [[GetPeerList alloc] init];
    GetPeerResult * gpr = [[GetPeerResult alloc] init];
    gpr = [gpl fromJsonToGetPeerResult : forJSONObject];
    return gpr;
}
///This is class function call the RPC method through the HttpHandler class and get the Json data back as input for the fromJsonObjToGetPeerResult function call
+(void) getPeerResultWithJsonParam:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_INFO_GET_PEERS];
}
@end
