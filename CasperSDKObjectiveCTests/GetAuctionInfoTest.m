#import <XCTest/XCTest.h>

#import "BlockIdentifier.h"
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetAuctionInfoResult.h"
@interface GetAuctionInfoTest : XCTestCase

@end

@implementation GetAuctionInfoTest

- (void) getGetAuctionInfo:(NSString*) jsonString {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get auction info"];
    NSString * casperURL = URL_TEST_NET;
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
            GetAuctionInfoResult * item = [[GetAuctionInfoResult alloc] init];
            item = [GetAuctionInfoResult fromJsonDictToGetAuctionResult:(NSDictionary*) forJSONObject[@"result"]];
            [item logInfo];
        } else {
            NSLog(@"Error get block with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetAuctionInfo {
    //Test 1: get state root hash without sending parameter
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString];
   
    //Test 2:get state root hash based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString2];
    //Test 3: get state root hash based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:12345];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString3];
    
    //Negative test
    //Test 4: get state root hash based on non-existing block height (too big height)
    //expected result: error thrown with message: get-auction-info failed to get specified block and error code:-32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString4];
    //Test 5: get state root hash based on non-existing block hash
    //expected result: error thrown with message: get-auction-info failed to get specified block and error code:-32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString5];
}

@end
