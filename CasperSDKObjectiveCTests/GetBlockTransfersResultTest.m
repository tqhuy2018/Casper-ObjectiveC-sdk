#import <XCTest/XCTest.h>
#import "GetBlockTransfersResult.h"
#import "BlockIdentifier.h"
#import "CasperErrorMessage.h"
#import "ConstValues.h"
@interface GetBlockTransfersResultTest : XCTestCase

@end

@implementation GetBlockTransfersResultTest

- (void) getBlockTransfersResultWithJsonString:(NSString*) jsonString {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get block transfers"];
    NSString * casperURL =  URL_TEST_NET;
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
            GetBlockTransfersResult * gbtr = [[GetBlockTransfersResult alloc] init];
            gbtr = [GetBlockTransfersResult fromJsonDictToGetBlockTransfersResult:forJSONObject];
            [gbtr logInfo];
        } else {
            NSLog(@"Error get block transfer with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetBlockTransfersResult {
    //Test 1: get block transfer without sending parameter
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString];

    //Test 2:get block transfer based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString2];
    //Test 3: get block transfer based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:12345];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString3];
    
    //Negative test
    //Test 4: get block transfer based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString4];
    //Test 5: get block transfer based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString5];
}
@end
