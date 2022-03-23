#import <XCTest/XCTest.h>

#import "BlockIdentifier.h"
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetEraInfoResult.h"
@interface GetEraInfoBySwitchBlockTest : XCTestCase

@end

@implementation GetEraInfoBySwitchBlockTest
- (void) getEraInfo:(NSString*) jsonString {
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
        } else {
            NSLog(@"Error get era info with error message:%@ and error code:%@",cem.message,cem.code);
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
    [self getEraInfo: jsonString];
   
    //Test 2:get state root hash based on block hash
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString2 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString2];
    
    //Test 3: get state root hash based on block height
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:318];
    NSString * jsonString3 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString3];
    
    //Negative test
    //Test 4: get state root hash based on non-existing block height (too big height)
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HEIGHT;
    [bi assignBlockHeigthtWithParam:123456789];
    NSString * jsonString4 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString4];
    //Test 5: get state root hash based on non-existing block hash
    //expected result: error thrown with message: block not known, error code: -32001
    bi.blockType = USE_BLOCK_HASH;
    [bi assignBlockHashWithParam:@"ccccb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
    NSString * jsonString5 = [bi toJsonStringWithMethodName:@"chain_get_era_info_by_switch_block"];
    [self getEraInfo: jsonString5];
}


@end
