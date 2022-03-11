#import <Foundation/Foundation.h>
#import "GetPeerList.h"
#import "GetPeerResult.h"
#import "PeerEntry.h"
@implementation GetPeerList
-(GetPeerResult*) fromJsonToPeerList:(NSDictionary*) nsData {
    NSLog([nsData objectForKey:@"jsonrpc"]);
    GetPeerResult * ret = [[GetPeerResult alloc] init];
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSArray * listPeer = [result objectForKey:@"peers"];
    NSInteger totalPeer = [listPeer count];
    NSLog(@"total peer:%d",totalPeer);
    NSMutableArray * listPeerEntry = [[NSMutableArray alloc]init];
    for (id obj in listPeer) {
        NSString * address = [obj objectForKey:@"address"];
        NSLog(@"Address is:%@",address);
        NSString * nodeID = [obj objectForKey:@"node_id"];
        PeerEntry * onePeer = [[PeerEntry alloc]init];
        [onePeer setupFromAddress:address andFromID:nodeID];
        [listPeerEntry addObject:onePeer];
    }
   // NSLog(@"%@", listPeer.count);
    printf("Done");
    return @"";
}
@end
