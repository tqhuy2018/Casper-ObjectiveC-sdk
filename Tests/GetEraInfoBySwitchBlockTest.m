#import <XCTest/XCTest.h>

#import <CasperSDKObjectiveC/BlockIdentifier.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/GetEraInfoResult.h>
#import <CasperSDKObjectiveC/EraInfo.h>
#import <CasperSDKObjectiveC/SeigniorageAllocation.h>
@interface GetEraInfoBySwitchBlockTest : XCTestCase

@end

@implementation GetEraInfoBySwitchBlockTest
- (void) getEraInfo:(NSString*) jsonString withCallIndex:(NSString*) callIndex {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get era info"];
    NSString * casperURL =  URL_TEST_NET;
    casperURL = URL_MAIN_NET;
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
            GetEraInfoResult * item = [[GetEraInfoResult alloc] init];
            item = [GetEraInfoResult fromJsonDictToGetEraInfoResult:(NSDictionary *)forJSONObject[@"result"]];
            [item logInfo];
            if([callIndex isEqualToString:@"call1"]) {
                XCTAssert(item.is_era_summary_existed == false);
            } else if([callIndex isEqualToString:@"call3"]) {
                XCTAssert(item.is_era_summary_existed == true);
                XCTAssert([item.era_summary.block_hash isEqualToString:@"f028506fb8add2edd3f9f3713e5acd7441a5d0cd433b863c627ff6542e8c0860"]);
                XCTAssert(item.era_summary.era_id == 2);
                XCTAssert([item.era_summary.state_root_hash isEqualToString:@"112bc563aae7ed8a55ff0e7cfc95929ab5b48d69bf11be124542eec40085ae16"]);
                XCTAssert(item.era_summary.merkle_proof.length == 26336);
                XCTAssert([item.era_summary.stored_value.itsType isEqualToString:@"EraInfo"]);
                EraInfo * ei = (EraInfo*) [item.era_summary.stored_value.innerValue objectAtIndex:0];
                XCTAssert([ei.seigniorage_allocations count] == 199);
                SeigniorageAllocation * sa = (SeigniorageAllocation*) [ei.seigniorage_allocations objectAtIndex:0];
                XCTAssert([sa.validator_public_key isEqualToString:@"01026ca707c348ed8012ac6a1f28db031fadd6eb67203501a353b867a08c8b9a80"]);
                XCTAssert([sa.delegator_public_key isEqualToString:@"01128ddb51119f1df535cf3a763996344ab0cc79038faaee0aaaf098a078031ce6"]);
                XCTAssert([sa.amount.itsValue isEqualToString:@"87735183835"]);
            }
        } else {
            NSLog(@"Error get era info with error message:%@ and error code:%@",cem.message,cem.code);
            if ([callIndex isEqualToString:@"call4"]) {
                XCTAssert([cem.message isEqualToString:@"block not known"]);
            } else if ([callIndex isEqualToString:@"call5"]) {
                XCTAssert([cem.message isEqualToString:@"block not known"]);
            }
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetEraInfoBySwitchBlock {
    //Test 1: get state root hash without sending parameter
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString withCallIndex:@"call1"];
   
    //Test 2:get state root hash based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString2 withCallIndex:@"call2"];
    
    //Test 3: get state root hash based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:318];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString3 withCallIndex:@"call3"];
    
    //Negative test
    //Test 4: get state root hash based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString4 withCallIndex:@"call4"];
    //Test 5: get state root hash based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString5 withCallIndex:@"call5"];
}


@end
