#import <XCTest/XCTest.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetItemParams.h"
@interface GetItemTest : XCTestCase

@end

@implementation GetItemTest

- (void) getItem:(NSString*) jsonString {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get item"];
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
            //NSLog(@"forJSONObject:%@",forJSONObject);
            //NSLog(@"DOne");
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetItem {
    return;
    GetItemParams * item = [[GetItemParams alloc] init];
    item.key = @"hash-b36478fa545160796de902e61ac504b33bc14624eea245a9df525b4d92d150bc";
    item.state_root_hash = @"83f6dca28102ecf1cf79d2e32172044b2eacf527e47a8781cead3850d01e6328";
    NSString * str = [item toJsonString];
    NSLog(@"send request str:%@",str);
    [self getItem:str];
    
}

@end
