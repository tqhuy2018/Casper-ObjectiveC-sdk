#import <XCTest/XCTest.h>
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetItemParams.h"
#import "GetItemResult.h"
@interface GetItemTest : XCTestCase

@end

@implementation GetItemTest

- (void) getItem:(NSString*) jsonString {
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
            GetItemResult * item = [[GetItemResult alloc] init];
            item = [GetItemResult fromJsonDictToGetItemResult:forJSONObject[@"result"]];
            [item logInfo];
        } else {
            NSLog(@"Error get item with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetItem {
    return;
    GetItemParams * item = [[GetItemParams alloc] init];
    //Test with StoredValue of type ContracPackage
    item.key = @"hash-b36478fa545160796de902e61ac504b33bc14624eea245a9df525b4d92d150bc";
    item.state_root_hash = @"83f6dca28102ecf1cf79d2e32172044b2eacf527e47a8781cead3850d01e6328";
    //Test with StoredValue of type Transfer
    item.key = @"transfer-8218fa8c55c19264e977bf2bae9f5889082aee4d2c4eaf9642478173c37d1ed4";
    item.state_root_hash = @"1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8";
    //Test with StoredValue of type DeployInfo
    item.key = @"deploy-a49c06f9b2adf02812a7b2fdcad08804a2ce4896ffec7c06c920d417e7e39cfe";
    item.state_root_hash = @"1416302b2c637647e2fe8c0b9f7ee815582cc7a323af5823313ff8a8684c8cf8";
    //Test with StoredValue of type Account
    item.state_root_hash = @"b31f42523b6799d6d403a3119596c958abf2cdba31066322f01e5fa38ef999aa";
    item.key = @"account-hash-ff2ae80f71c1ffcac4921100a21b67ddecf59a30fb86eb6979f47c8838b3b7d3";
    //Test with StoredValue of type Bid
    item.state_root_hash = @"647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86";
    item.key = @"bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD";
    //Test with StoredValue of type CLType
    item.state_root_hash = @"340a09b06bae99d868c68111b691c70d9d5a253c0f2fd7ee257a04a198d3818e";
    item.key = @"uref-ba620eee2b06c6df4cd8da58dd5c5aa6d42f3a502de61bb06dc70b164eee4119-007";
    //Test with StoredValue of type Withdraw
    item.state_root_hash = @"d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    NSString * str = [item toJsonString];
    [self getItem:str];
    
    //Test with negative path
    //1. use fake state_root_hash, an Error with the following content will be thrown
    //Error:CasperError(code: -32602, message: "Invalid params", methodCall: "state_get_item")
    item.state_root_hash = @"MMM0e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    str = [item toJsonString];
    [self getItem:str];
    //2. use fake key, an Error with the following content will be thrown
    //Error:CasperError(code: -32002, message: "failed to parse key: withdraw-key from string error: Invalid byte `b\'f\'`, at index 1.", methodCall: "state_get_item")
    item.state_root_hash = @"d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228";
    item.key = @"withdraw-DF167278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1";
    str = [item toJsonString];
    [self getItem:str];
    //3. test with a bid that not found
    item.state_root_hash = @"647C28545316E913969B032Cf506d5D242e0F857061E70Fb3DF55980611ace86";
    item.key = @"bid-24b6D5Aabb8F0AC17D272763A405E9CECa9166B75B745Cf200695E172857c2dD";
    str = [item toJsonString];
    [self getItem:str];
}

@end
