#import <Foundation/Foundation.h>
#import "GetPeerList.h"
@implementation GetPeerList
-(NSString*) fromJsonToPeerList:(NSDictionary*) nsData {
    NSLog([nsData objectForKey:@"jsonrpc"]);
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSArray * listPeer = [result objectForKey:@"peers"];
    NSInteger totalPeer = [listPeer count];
    NSLog(@"total peer:%d",totalPeer);
   // NSLog(@"%@", listPeer.count);
    printf("Done");
    return @"";
}
@end
