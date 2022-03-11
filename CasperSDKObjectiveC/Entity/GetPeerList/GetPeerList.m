#import <Foundation/Foundation.h>
#import "GetPeerList.h"
#import "GetPeerResult.h"
#import "PeerEntry.h"
@implementation GetPeerList
-(GetPeerResult*) fromJsonToPeerList:(NSDictionary*) nsData {
    GetPeerResult * ret = [[GetPeerResult alloc] init];
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSString * apiVersion = [result objectForKey:@"api_version"];
    NSArray * listPeer = [result objectForKey:@"peers"];
    NSInteger totalPeer = [listPeer count];
    NSLog(@"total peer:%i and api_version:%@",totalPeer,apiVersion);
    NSMutableArray * listPeerEntry = [[NSMutableArray alloc]init];
    for (id obj in listPeer) {
        NSString * address = [obj objectForKey:@"address"];
        //NSLog(@"Address is:%@",address);
        NSString * nodeID = [obj objectForKey:@"node_id"];
        PeerEntry * onePeer = [[PeerEntry alloc]init];
        [onePeer setupFromAddress:address andFromID:nodeID];
        [listPeerEntry addObject:onePeer];
    }
    [ret setupWithApiVersion:apiVersion andPeerMap:listPeerEntry];
   // NSLog(@"%@", listPeer.count);
    printf("Done");
    return ret;
}
@end
