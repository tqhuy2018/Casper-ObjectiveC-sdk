#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/GetBlockTransfersResult.h>
#import <CasperSDKObjectiveC/BlockIdentifier.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/Transfer.h>
@interface GetBlockTransfersResultTest : XCTestCase

@end

@implementation GetBlockTransfersResultTest

- (void) getBlockTransfersResultWithJsonString:(NSString*) jsonString withCallIndex:(NSString*) callIndex{
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
            if([callIndex isEqualToString:@"call2"]) {
                XCTAssert([gbtr.block_hash isEqualToString:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"]);
                XCTAssert(gbtr.transfers.count == 0);
            } else if([callIndex isEqualToString:@"call3"]) {
                XCTAssert([gbtr.block_hash isEqualToString:@"04c4328b7fa536b71adff3837560384eee44e157791d042f0dba252d6fa8b097"]);
                XCTAssert(gbtr.transfers.count == 1);
                Transfer * transfer = [gbtr.transfers objectAtIndex:0];
                XCTAssert([transfer.deploy_hash isEqualToString:@"84783d9dd336e541628dfe09e63e9cc2ed376e42c71d25ceaf19b6d3ac8e0560"]);
                XCTAssert([transfer.amount.itsValue isEqualToString:@"9000000000000"]);
                XCTAssert([transfer.gas.itsValue isEqualToString:@"0"]);
                XCTAssert([transfer.from isEqualToString:@"account-hash-e70b850efb68c64e2443da2386452b0d8e4e799362edef0ff56eea8efb114815"]);
                XCTAssert([transfer.source isEqualToString:@"uref-0a24ef56971d46bfefbd5590afe20e5f3482299aba74e1a0fc33a55008cf9453-007"]);
                XCTAssert([transfer.target isEqualToString:@"uref-a9a82dd4ee57802a38ccb7f8600940101d7cd9bbf1fd6665d9f7317b5c0e3a15-007"]);
            }
        } else {
            NSLog(@"Error get block transfer with error message:%@ and error code:%@",cem.message,cem.code);
            if([callIndex isEqualToString:@"call4"]) {
                XCTAssert([cem.message isEqualToString:@"block not known"]);
            }
            if([callIndex isEqualToString:@"call5"]) {
                XCTAssert([cem.message isEqualToString:@"block not known"]);
            }
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetBlockTransfersResult {
    return;
    //Test 1: get block transfer without sending parameter
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString withCallIndex:@"call1"];

    //Test 2:get block transfer based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString2 withCallIndex:@"call2"];
    //Test 3: get block transfer based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:106];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString3 withCallIndex:@"call3"];
    
    //Negative test
    //Test 4: get block transfer based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString4 withCallIndex:@"call4"];
    //Test 5: get block transfer based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"chain_get_block_transfers"];
    [self getBlockTransfersResultWithJsonString:jsonString5 withCallIndex:@"call5"];
}
@end
