#import <XCTest/XCTest.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetBalanceParams.h"
#import "GetBalanceResult.h"
@interface GetBalanceTest : XCTestCase

@end

@implementation GetBalanceTest

- (void) getBalance:(NSString*) jsonString {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get balance"];
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = @"https://node-clarity-mainnet.make.services/rpc";
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
        CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
        [cem fromJsonToErrorObject:forJSONObject];
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            GetBalanceResult * item = [[GetBalanceResult alloc] init];
            item = [GetBalanceResult fromJsonDictToGetBalanceResult:(NSDictionary *)forJSONObject[@"result"]];
            [item logInfo];
            XCTAssert([item.balance_value.itsValue isEqualToString:@"522693296224"]);
            XCTAssert(item.merkle_proof.length == 31766);
        } else {
            NSLog(@"Error get balance with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetBalance {
    return;
    GetBalanceParams * param = [[GetBalanceParams alloc] init];
    param.state_root_hash = @"8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189";
    param.purse_uref = @"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
    NSString * jsonStr = [param toJsonString];
    [self getBalance:jsonStr];
}

@end
