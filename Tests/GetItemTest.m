#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/GetItemParams.h>
#import <CasperSDKObjectiveC/GetItemResult.h>
#import <CasperSDKObjectiveC/StoredValue.h>
#import <CasperSDKObjectiveC/Transform_WriteWithdraw.h>
#import <CasperSDKObjectiveC/UnbondingPurse.h>
@interface GetItemTest : XCTestCase

@end

@implementation GetItemTest

- (void) getItem:(NSString*) jsonString withCallIndex:(NSString*) callIndex {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get item"];
    NSString * casperURL = URL_TEST_NET;
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
            GetItemResult * item = [[GetItemResult alloc] init];
            item = [GetItemResult fromJsonDictToGetItemResult:forJSONObject[@"result"]];
            if([callIndex isEqualToString:@"call1"]) {
                XCTAssert(item.merkle_proof.length  == 6876);
                XCTAssert([item.stored_value.itsType isEqualToString:@"Withdraw"]);
                Transform_WriteWithdraw * tww = (Transform_WriteWithdraw*) [item.stored_value.innerValue objectAtIndex:0];
                XCTAssert([tww.UnbondingPurseList count] == 1);
                UnbondingPurse * up = (UnbondingPurse*) [tww.UnbondingPurseList objectAtIndex:0];
                XCTAssert([up.bonding_purse isEqualToString:@"uref-5fcc3031ea2572f9929e0cfcfc84c6c3131bfe1e78bce8cb61f99f59eace7795-007"]);
                XCTAssert([up.validator_public_key isEqualToString:@"01d949a3a1963db686607a00862f79b76ceb185fc134d0aeedb686f1c151f4ae54"]);
                XCTAssert([up.unbonder_public_key isEqualToString:@"01d949a3a1963db686607a00862f79b76ceb185fc134d0aeedb686f1c151f4ae54"]);
                XCTAssert(up.era_of_creation == 3319);
                XCTAssert([up.amount.itsValue isEqualToString:@"500"]);
            }
        } else {
            NSLog(@"Error get item with error message:%@ and error code:%@",cem.message,cem.code);
            if([callIndex isEqualToString:@"call2"]) {
                XCTAssert([cem.message isEqualToString:@"Invalid params"]);
            } else  if([callIndex isEqualToString:@"call3"]) {
                XCTAssert([cem.message isEqualToString:@"failed to parse key: withdraw-key from string error: Invalid byte `b'f'`, at index 1."]);
            }  else  if([callIndex isEqualToString:@"call4"]) {
                XCTAssert([cem.message isEqualToString:@"state query failed: RootNotFound"]);
            }
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetItem {
    GetItemParams * item = [[GetItemParams alloc] init];
    //Test with StoredValue of type Withdraw
    item.state_root_hash = @"d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    NSString * str = [item toJsonString];
    [self getItem:str withCallIndex:@"call1"];

    //Test with negative path
    //1. use fake state_root_hash, an Error with the following content will be thrown
    //Error:CasperError(code: -32602, message: "Invalid params", methodCall: "state_get_item")
    item.state_root_hash = @"MMM0e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    str = [item toJsonString];
    [self getItem:str withCallIndex:@"call2"];
    //2. use fake key, an Error with the following content will be thrown
    //Error:CasperError(code: -32002, message: "failed to parse key: withdraw-key from string error: Invalid byte `b\'f\'`, at index 1.", methodCall: "state_get_item")
    item.state_root_hash = @"d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-DF167278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    str = [item toJsonString];
    [self getItem:str withCallIndex: @"call3"];
    //3. test with a bid that not found
    item.state_root_hash = @"647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86";
    item.key = @"bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD";
    str = [item toJsonString];
    [self getItem:str withCallIndex:@"call4"];
}

@end
