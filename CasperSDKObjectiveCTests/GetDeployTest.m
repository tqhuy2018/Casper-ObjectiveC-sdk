#import <XCTest/XCTest.h>

#import "CasperErrorMessage.h"
#import "ConstValues.h"

@interface GetDeployTest : XCTestCase

@end


@implementation GetDeployTest
- (void) getDeploy:(NSString*) jsonString {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get block"];
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
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
            
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDeploy {
    return;
    NSLog(@"test getDeploy");
    
}

@end
