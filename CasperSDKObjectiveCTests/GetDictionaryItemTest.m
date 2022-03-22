#import <XCTest/XCTest.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetItemParams.h"
#import "GetDictionaryItemParams.h"
#import "GetDictionaryItemResult.h"
#import "DictionaryIdentifier_AccountNamedKey.h"
@interface GetDictionaryItemTest : XCTestCase

@end

@implementation GetDictionaryItemTest

- (void) getDictionaryItem:(NSString*) jsonString {
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
            GetDictionaryItemResult * item = [[GetDictionaryItemResult alloc] init];
            item = [GetDictionaryItemResult fromJsonDictToGetItemResult:(NSDictionary *)forJSONObject[@"result"]];
            [item logInfo];
        } else {
            NSLog(@"Error get dictionary item with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDictionaryItem {
    return;
    GetDictionaryItemParams * itemParam = [[GetDictionaryItemParams alloc] init];
    DictionaryIdentifier_AccountNamedKey * item = [[DictionaryIdentifier_AccountNamedKey alloc] init];
    item.key = @"";
    item.dictionary_name = @"";
}

@end
