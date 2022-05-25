#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/BlockIdentifier.h>
#import <CasperSDKObjectiveC/GetStateRootHash.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@interface GetStateRootHashTest : XCTestCase

@end

@implementation GetStateRootHashTest
-(void) getStateRootHashWithJsonParam:(NSString*) jsonString withIndexStr:(NSString*) indexStr {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get state root hash"];
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
            NSString * state_root_hash = [GetStateRootHash fromJsonToStateRootHash: forJSONObject];
            if([indexStr isEqualToString:@"call2"]) {
                // call2 get state root hash base on block hash "d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"
                XCTAssert([state_root_hash isEqualToString:@"6da6cb8ff1e35656fba9a71868af803abef40dd6fce6161d2a18fe339a0525cb"]);
            } else if([indexStr isEqualToString:@"call3"]) {
                // call2 get state root hash base on block height 12345
                XCTAssert([state_root_hash isEqualToString:@"a42c238d2d850b4d9c3efac6104bbfad6b91ce1ca38733c332e35a3459166a58"]);
            } else if([indexStr isEqualToString:@"call1"]) {
                XCTAssert([state_root_hash length] > 0);
            }
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
           // [session closeWithCompletionHandler:nil];
        }];
}
- (void) testGetStateRootHash {
    return;
    NSLog(@"M1: chain_get_state_root_hash test cases");
    //Test 1: get state root hash without sending parameter
    //expected result: latest block state root hash
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    NSString * jsonString = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [self getStateRootHashWithJsonParam:jsonString withIndexStr:@"call1"];
    //Test 2:get state root hash based on block hash
    //expected result: state root hash of the block with given hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
   // [bi assignBlockHashWithParam:@"00b1b35ee5d8bddfc70de6d8d769c49eec81511fee98102e1a6fea3b50524e9e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [self getStateRootHashWithJsonParam:jsonString2 withIndexStr:@"call2"];
    //Test 3: get state root hash based on block height
    //expected result: state root hash of the block with given height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:12345];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [self getStateRootHashWithJsonParam:jsonString3 withIndexStr:@"call3"];
    //Negative test
    //Test 4: get state root hash based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [self getStateRootHashWithJsonParam:jsonString4 withIndexStr:@"call4"];
    //Test 5: get state root hash based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [self getStateRootHashWithJsonParam:jsonString5 withIndexStr:@"call5"];
}
@end
