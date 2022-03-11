#import <Foundation/Foundation.h>
#import "GetPeerResult.h"
@implementation GetPeerResult
-(void) setupWithApiVersion:(NSString*) apiVersion andPeerMap:(NSMutableArray*) peerMapList {
    self.api_version = apiVersion;
    self.PeersMap = [[NSMutableArray alloc] init];
    self.PeersMap = peerMapList;
}
@end
