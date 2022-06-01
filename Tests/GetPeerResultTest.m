#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
#import <CasperSDKObjectiveC/GetStateRootHash.h>
#import <CasperSDKObjectiveC/GetPeerList.h>
#import <CasperSDKObjectiveC/GetPeerResult.h>
#import <CasperSDKObjectiveC/BlockIdentifier.h>
#import <CasperSDKObjectiveC/PeerEntry.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@interface GetPeerResultTest : XCTestCase

@end

@implementation GetPeerResultTest
- (void) testGetPeerList {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get peer list"];
    NSString * casperURL =  URL_TEST_NET;
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
        XCTAssert(gpr.api_version.length > 4);
        NSInteger totalPeer = [gpr.PeersMap count];
        XCTAssert(totalPeer > 100);
        NSInteger  counter = 1;
        XCTAssert(totalPeer>0);
        for (int i = 0 ; i < totalPeer;i ++) {
            PeerEntry * pe = [[PeerEntry alloc] init];
            pe = [gpr.PeersMap objectAtIndex:i];
            int nodeIDStrLength = (int) [pe.nodeID length];
            int addressStrLength = (int) [pe.address length];
            XCTAssert(addressStrLength >10);
            XCTAssert(nodeIDStrLength == 14);
            counter = counter + 1;
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
        }];
}
@end
