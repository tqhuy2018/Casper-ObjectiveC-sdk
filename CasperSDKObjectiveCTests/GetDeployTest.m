#import <XCTest/XCTest.h>

#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "CLType.h"
#import "CLTypeList.h"
#import "CLTypeMap.h"
#import "CLParsed.h"
#import "CLParsedPBool.h"
#import "CLParsedList.h"
#import "CLParsedPString.h"
#import "CLParsedMap.h"
#import "GetDeployResult.h"
#import "GetDeployParams.h"
@interface GetDeployTest : XCTestCase

@end


@implementation GetDeployTest
- (void) getDeploy:(NSString*) jsonString {
    return;
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get block"];
    NSString * casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    casperURL = @"https://node-clarity-mainnet.make.services/rpc";
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
            GetDeployResult * ret = [[GetDeployResult alloc] init];
            ret = [GetDeployResult fromJsonDictToGetDeployResult:forJSONObject[@"result"]];
            [ret logInfo];
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDeploy {
    return;
    GetDeployParams * gpr = [[GetDeployParams alloc] init];
   // gpr.deploy_hash = @"777253965d76166caba6a4b861a2b4f0bfdfa8bfd46abbcf48f6a1b2cdff02f4";
    //List(Tuple2(Key,U256)
   // gpr.deploy_hash = @"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc";
    //List(Map(String,String)
   // gpr.deploy_hash = @"AaB4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268";
    //List(Map(String,String)  in session StoredContractByHash
   // gpr.deploy_hash = @"a91d468e2ddc8936f7866bc594794b322f747508c2192fd4eca90ef8a121d45e";
    //BytesArray, Bool,U512
    gpr.deploy_hash = @"1d113022631c587444166e4d1efbc3d475e49b28b90f1414d9cadee6dcddf65f";
    //ModuleBytes blank for session
    gpr.deploy_hash = @"2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61";
    //List(Tuple2(Key,U256)) in session ModuleBytes
    gpr.deploy_hash = @"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc";
    //Option, U32, U64, Key, List(String),U512
    gpr.deploy_hash = @"9ff98d8027795a002e41a709d5b5846e49c2e9f9c8bfbe74e4c857adc26d5571";
    //U256,URef, U64,Key,List(String)
    gpr.deploy_hash = @"0fe0adccf645e99b9b58493c843516cd354b189e1c3efe62c4f2768716a41932";
    //U8, List(U8), List(ByteArray)
    gpr.deploy_hash = @"ac654d996f17720e780fe4eae9a7d57d57cdadb069998666a369a0833aebb7f8";
    //PublicKey, Option(U64)
    gpr.deploy_hash = @"fa02357bffd204b34d3a3495f393fc5651541e1be4376072d6d94297daa688d6";
    //Transform of type Withdraw and Bid
    //gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    //Transform of type WriteBid and WriteWithdraw
    gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    NSString * jsonString = [gpr generatePostParam];
    [self getDeploy:jsonString];
    return;
    //This test is for CLTYPE
    //List(Map(String,String)) alloc
    //Method 1
    CLTypeList * cll = [[CLTypeList alloc] init];
    cll.itsType = @"List";
    cll.innerType1 = [[CLType alloc] init];
    cll.innerType1.innerType1 = [[CLType alloc] init];
    cll.innerType1.innerType2 = [[CLType alloc] init];
    cll.innerType1.itsType = @"Map";
    cll.is_innerType1_exists = true;
    cll.innerType1.innerType1.itsType = @"String";
    cll.innerType1.innerType2.itsType = @"String";
    cll.innerType1.is_innerType1_exists = true;
    cll.innerType1.is_innerType2_exists = true;
    [cll logInfo];
    //Method 2
    CLTypeList * cll2 = [[CLTypeList alloc] init];
    cll2.innerType1.itsType = @"Map";
    cll2.innerType1 = [[CLTypeMap alloc] init];
    cll2.innerType1.innerType1.itsType = @"String";
    cll2.innerType1.innerType2.itsType = @"String";
   // [cll2 logInfo];
    //For CLParsed
    CLParsedPBool * bool1 = [[CLParsedPBool alloc] init];
    bool1.itsPrimitiveValue = @"true";
    CLParsedPBool * bool2 = [[CLParsedPBool alloc] init];
    bool2.itsPrimitiveValue = @"false";
    CLParsedPBool * bool3 = [[CLParsedPBool alloc] init];
    bool3.itsPrimitiveValue = @"true";
    CLParsedList * list = [[CLParsedList alloc] init];
    [list.arrayValue addObject: bool1];
    [list.arrayValue addObject: bool2];
    [list.arrayValue addObject: bool3];
   // [list logInfo];
    //List of String
    CLParsedPString * str1 = [[CLParsedPString alloc] init];
    str1.itsPrimitiveValue = @"Hello world1";
    CLParsedPString * str2 = [[CLParsedPString alloc] init];
    str2.itsPrimitiveValue = @"Hello world2";
    CLParsedPString * str3 = [[CLParsedPString alloc] init];
    str3.itsPrimitiveValue = @"Hello world3";
    CLParsedList * list2 = [[CLParsedList alloc] init];
   
    [list2.arrayValue addObject: str1];
    [list2.arrayValue addObject: str2];
    [list2.arrayValue addObject: str3];
    //[list2 logInfo];
    //List(Map(String,String))
    CLParsedList * list3 = [[CLParsedList alloc] init];
    CLParsedMap * map = [[CLParsedMap alloc] init];
    map.innerParsed1 = [[CLParsedList alloc] init];
    map.innerParsed2 = [[CLParsedList alloc] init];
    CLParsedPString * key1 = [[CLParsedPString alloc] init];
    key1.itsPrimitiveValue = @"name";
    CLParsedPString * key2 = [[CLParsedPString alloc] init];
    key2.itsPrimitiveValue = @"description";
    CLParsedPString * key3 = [[CLParsedPString alloc] init];
    key3.itsPrimitiveValue = @"ipfs_url";

    CLParsedPString * value1 = [[CLParsedPString alloc] init];
    value1.itsPrimitiveValue = @"Test Prod Admin";
    CLParsedPString * value2 = [[CLParsedPString alloc] init];
    value2.itsPrimitiveValue = @"Testing";
    CLParsedPString * value3 = [[CLParsedPString alloc] init];
    value3.itsPrimitiveValue = @"https://gateway.pinata.cloud/ipfs/QmauPU5rc8ghhyZFQxB9R5jCbaafGw2MneQJRMDWLVzjaU";
    //for key
    [map.innerParsed1.arrayValue addObject: key1];
    [map.innerParsed1.arrayValue addObject: key2];
    [map.innerParsed1.arrayValue addObject: key3];
    
    [map.innerParsed2.arrayValue addObject: value1];
    [map.innerParsed2.arrayValue addObject: value2];
    [map.innerParsed2.arrayValue addObject: value3];
    //for value
    [list3.arrayValue addObject:map];
    [list3 logInfo];
    
}

@end
