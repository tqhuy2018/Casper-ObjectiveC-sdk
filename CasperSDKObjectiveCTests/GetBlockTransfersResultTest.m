#import <XCTest/XCTest.h>
#import "GetBlockTransfersResult.h"
@interface GetBlockTransfersResultTest : XCTestCase

@end

@implementation GetBlockTransfersResultTest

- (void) testGetBlockTransfersResultWithJsonString:(NSString*) jsonString {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get peer list"];
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
   // NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_status\",\"jsonrpc\" : \"2.0\"}";
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
        GetBlockTransfersResult * gbtr = [[GetBlockTransfersResult alloc] init];
        gbtr = [GetBlockTransfersResult fromJsonDictToGetBlockTransfersResult:forJSONObject];
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}

@end
