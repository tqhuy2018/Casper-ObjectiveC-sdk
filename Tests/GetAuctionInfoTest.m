#import <XCTest/XCTest.h>

#import <CasperSDKObjectiveC/BlockIdentifier.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/GetAuctionInfoResult.h>
#import <CasperSDKObjectiveC/JsonEraValidators.h>
#import <CasperSDKObjectiveC/JsonValidatorWeights.h>
@interface GetAuctionInfoTest : XCTestCase

@end

@implementation GetAuctionInfoTest

- (void) getGetAuctionInfo:(NSString*) jsonString withCallIndex:(NSString*) callIndex {
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
            if([callIndex isEqualToString:@"call2"]) {
                XCTAssert([item.auction_state.state_root_hash isEqualToString:@"6da6cb8ff1e35656fba9a71868af803abef40dd6fce6161d2a18fe339a0525cb"]);
                XCTAssert(item.auction_state.block_height == 602343);
                XCTAssert([item.auction_state.era_validators count] == 2);
                JsonEraValidators * jev = (JsonEraValidators*)[item.auction_state.era_validators objectAtIndex:0];
                XCTAssert(jev.era_id == 4026);
                XCTAssert([jev.validator_weights count] == 100);
                JsonValidatorWeights * jvw = (JsonValidatorWeights*) [jev.validator_weights objectAtIndex:0];
                XCTAssert([jvw.public_key isEqualToString:@"0101f5170c996cc02b581d8200f0d95a737840234f31bf1fa21cca35137f8507b0"]);
                XCTAssert([jvw.weight.itsValue isEqualToString:@"1226198285443"]);
            } else if([callIndex isEqualToString:@"call3"]) {
                XCTAssert([item.auction_state.state_root_hash isEqualToString:@"a42c238d2d850b4d9c3efac6104bbfad6b91ce1ca38733c332e35a3459166a58"]);
                XCTAssert(item.auction_state.block_height == 12345);
                XCTAssert([item.auction_state.era_validators count] == 2);
                JsonEraValidators * jev = (JsonEraValidators*)[item.auction_state.era_validators objectAtIndex:0];
                XCTAssert(jev.era_id == 177);
                XCTAssert([jev.validator_weights count] == 100);
                JsonValidatorWeights * jvw = (JsonValidatorWeights*) [jev.validator_weights objectAtIndex:0];
                XCTAssert([jvw.public_key isEqualToString:@"0105220d6629f6ef4484e2da5f58b6222832af8cabba4fbd7f1ad55e84a06ab319"]);
                XCTAssert([jvw.weight.itsValue isEqualToString:@"21250662917014"]);
            }
        } else {
            NSLog(@"Error get block with error message:%@ and error code:%@",cem.message,cem.code);
            XCTAssert([cem.message isEqualToString:@"get-auction-info failed to get specified block"]);
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
    [self getGetAuctionInfo: jsonString withCallIndex:@"call1"];
   
    //Test 2:get state root hash based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString2 withCallIndex:@"call2"];
    //Test 3: get state root hash based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:12345];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString3 withCallIndex:@"call3"];
    
    //Negative test
    //Test 4: get state root hash based on non-existing block height (too big height)
    //expected result: error thrown with message: get-auction-info failed to get specified block and error code:-32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString4 withCallIndex:@"call4"];
    //Test 5: get state root hash based on non-existing block hash
    //expected result: error thrown with message: get-auction-info failed to get specified block and error code:-32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"state_get_auction_info"];
    [self getGetAuctionInfo: jsonString5 withCallIndex:@"call5"];
}

@end
