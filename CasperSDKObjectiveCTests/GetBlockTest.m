#import <XCTest/XCTest.h>
#import "BlockIdentifier.h"
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetBlockResult.h"
@interface GetBlockTest : XCTestCase

@end

@implementation GetBlockTest

- (void) getBlock:(NSString*) jsonString withCallIndex:(NSString*) callIndex {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get block"];
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
            GetBlockResult * gbr = [[GetBlockResult alloc] init];
            gbr = [GetBlockResult fromJsonDictToGetBlockResult:(NSDictionary*) forJSONObject[@"result"]];
            [gbr logInfo];
            if([callIndex isEqualToString:@"call2"]) {
                XCTAssert([gbr.block.blockHash isEqualToString:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"]);
                XCTAssert([gbr.block.header.parent_hash isEqualToString:@"ec18afdd3df5c1b0f3caf7f564105f3329cd7b2ef59391c4ce13f1e9173b39b4"]);
                XCTAssert([gbr.block.header.state_root_hash isEqualToString:@"6da6cb8ff1e35656fba9a71868af803abef40dd6fce6161d2a18fe339a0525cb"]);
                XCTAssert([gbr.block.header.body_hash isEqualToString:@"cde00a26358a0ac039b730e4ee8f70d95fba48ee4be0690142b32fa5e898f2e3"]);
                XCTAssert(gbr.block.header.random_bit == 1);
                XCTAssert([gbr.block.header.accumulated_seed isEqualToString:@"8186dd2710cb3eaa5554bf7a6f6cad789877cfad3a9d151b6769e8a0feaba5bd"]);
                XCTAssert([gbr.block.header.timestamp isEqualToString:@"2022-03-11T04:57:11.936Z"]);
                XCTAssert(gbr.block.header.era_id == 4026);
                XCTAssert(gbr.block.header.height == 602343);
                XCTAssert([gbr.block.body.proposer isEqualToString:@"01ace6578907bfe6eba3a618e863bbe7274284c88e405e2857be80dd094726a223"]);
                XCTAssert([gbr.block.body.deploy_hashes count] == 0);
                XCTAssert([gbr.block.body.transfer_hashes count] == 0);
                XCTAssert([gbr.block.proofs count] == 97);
            } else  if([callIndex isEqualToString:@"call3"]) {
                XCTAssert([gbr.block.blockHash isEqualToString:@"bbf21fe52a97c64e6b95098b1f2e098337efc9f9b63ae2ba0de37ef5a0da4b6f"]);
                XCTAssert([gbr.block.header.parent_hash isEqualToString:@"3a9e5db55a8c5a2e07fb1526d80fbf4c64745ab5303e56a684334e08a6ade2e0"]);
                XCTAssert([gbr.block.header.state_root_hash isEqualToString:@"a42c238d2d850b4d9c3efac6104bbfad6b91ce1ca38733c332e35a3459166a58"]);
                XCTAssert([gbr.block.header.body_hash isEqualToString:@"1086c5c5f3d04e3729fd9832e646a053d81b207ae9202af57a4f1d6a55c9303a"]);
                XCTAssert(gbr.block.header.random_bit == 1);
                XCTAssert([gbr.block.header.accumulated_seed isEqualToString:@"ddff74b667ff1337aba501dde16f9a98e014dbb3daca89829852db7ddfc91f2b"]);
                XCTAssert([gbr.block.header.timestamp isEqualToString:@"2021-04-23T23:15:09.952Z"]);
                XCTAssert(gbr.block.header.era_id == 177);
                XCTAssert(gbr.block.header.height == 12345);
                XCTAssert([gbr.block.body.proposer isEqualToString:@"0152b2b3cc1de020e0cfb5887d0fda5d99da5decaf98af90f13144e97d0e35eeaa"]);
                XCTAssert([gbr.block.body.deploy_hashes count] == 0);
                XCTAssert([gbr.block.body.transfer_hashes count] == 0);
                XCTAssert([gbr.block.proofs count] == 100);
            }
        } else {
            NSLog(@"Error get block with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetBlock {
    //Test 1: get block without sending parameter
    //expected result: latest block state root hash
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_block"];
    [self getBlock: jsonString withCallIndex:@"call1"];
    //Test 2:get block based on block hash
    //expected result: state root hash of the block with given hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"chain_get_block"];
    [self getBlock: jsonString2 withCallIndex:@"call2"];
    //Test 3: get block based on block height
    //expected result: state root hash of the block with given height, transfer result blank list
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:12345];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"chain_get_block"];
    [self getBlock: jsonString3 withCallIndex:@"call3"];
    //Negative test
    //Test 4: get block based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"chain_get_block"];
    [self getBlock: jsonString4 withCallIndex:@"call4"];
    //Test 5: get block based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"chain_get_block"];
    [self getBlock: jsonString5 withCallIndex:@"call5"];
}

@end
