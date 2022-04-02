#import <Foundation/Foundation.h>
#import "GetPeerList.h"
#import "GetPeerResult.h"
#import "PeerEntry.h"
@implementation GetPeerList
/**This function parse the NSDictionary object to GetPeerResult object
 When send POST request in info_get_peers RPC call, the result is sent back as Json data, in type of key-value pairs.
 This function parse the JSON to get the GetPeerResult object
 */
-(GetPeerResult*) fromJsonToGetPeerResult:(NSDictionary*) fromDict {
    GetPeerResult * ret = [[GetPeerResult alloc] init];
    NSDictionary * result = [fromDict objectForKey:@"result"];
    NSString * apiVersion = [result objectForKey:@"api_version"];
    NSArray * listPeer = [result objectForKey:@"peers"];
    NSMutableArray * listPeerEntry = [[NSMutableArray alloc]init];
    for (id obj in listPeer) {
        NSString * address = [obj objectForKey:@"address"];
        NSString * nodeID = [obj objectForKey:@"node_id"];
        PeerEntry * onePeer = [[PeerEntry alloc]init];
        [onePeer setupFromAddress:address andFromID:nodeID];
        [listPeerEntry addObject:onePeer];
    }
    [ret setupWithApiVersion:apiVersion andPeerMap:listPeerEntry];
    return ret;
}
/**This function parse the NSDictionary object to PeerEntry List
 The NSDictionary object stored in fromDict input is also a part of the JSON back from the  info_get_peers RPC call
 */

+(NSMutableArray*) fromJsonToPeerMap:(NSDictionary*) fromDict {
    NSArray * listPeer = [fromDict objectForKey:@"peers"];
    NSMutableArray * listPeerEntry = [[NSMutableArray alloc]init];
    for (id obj in listPeer) {
        NSString * address = [obj objectForKey:@"address"];
        NSString * nodeID = [obj objectForKey:@"node_id"];
        PeerEntry * onePeer = [[PeerEntry alloc]init];
        [onePeer setupFromAddress:address andFromID:nodeID];
        [listPeerEntry addObject:onePeer];
    }
    return listPeerEntry;
}

@end
