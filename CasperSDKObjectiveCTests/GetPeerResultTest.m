#import <XCTest/XCTest.h>
#import "HttpHandler.h"
#import "GetStateRootHash.h"
#import "GetPeerList.h"
#import "GetPeerResult.h"
#import "BlockIdentifier.h"
#import "PeerEntry.h"

@interface GetPeerResultTest : XCTestCase

@end

@implementation GetPeerResultTest
- (void) testGetPeerList {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get peer list"];
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_peers\",\"jsonrpc\" : \"2.0\"}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [requestExpectation fulfill];
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        GetPeerResult * gpr = [[GetPeerResult alloc] init];
        gpr = [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
        NSLog(@"Get peer result api_version:%@",gpr.api_version);
        NSLog(@"Get peer result, total peer entry:%lu",[gpr.PeersMap count]);
        NSLog(@"List of peer printed out:");
        NSInteger totalPeer = [gpr.PeersMap count];
        NSInteger  counter = 1;
        for (int i = 0 ; i < totalPeer;i ++) {
            PeerEntry * pe = [[PeerEntry alloc] init];
            pe = [gpr.PeersMap objectAtIndex:i];
            NSLog(@"Peer number %lu address:%@ and node id:%@",counter,pe.address,pe.nodeID);
            counter = counter + 1;
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
@end
