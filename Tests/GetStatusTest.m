#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/GetStatusResult.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/PeerEntry.h>
@interface GetStatusTest : XCTestCase

@end

@implementation GetStatusTest

- (void) testGetStatus {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get status"];
    NSString * casperURL =  URL_TEST_NET;
    NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_status\",\"jsonrpc\" : \"2.0\"}";
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
        GetStatusResult * gsr = [[GetStatusResult alloc] init];
        gsr = [GetStatusResult fromJsonDictToGetStatusResult:forJSONObject];
        XCTAssert([gsr.chainspec_name isEqualToString:@"casper-test"]);
        XCTAssert(gsr.peers.count > 0);
        XCTAssert(gsr.starting_state_root_hash.length > 0);
        
        NSInteger totalPeer = [gsr.peers count];
        XCTAssert(totalPeer > 100);
        NSInteger  counter = 1;
        XCTAssert(totalPeer>0);
        for (int i = 0 ; i < totalPeer;i ++) {
            PeerEntry * pe = [[PeerEntry alloc] init];
            pe = [gsr.peers objectAtIndex:i];
            int nodeIDStrLength = (int) [pe.nodeID length];
            int addressStrLength = (int) [pe.address length];
            XCTAssert(addressStrLength >10);
            XCTAssert(nodeIDStrLength == 14);
            counter = counter + 1;
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}

@end
