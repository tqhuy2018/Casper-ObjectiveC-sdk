#import <XCTest/XCTest.h>

#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "CLType.h"
#import "CLParsed.h"
#import "GetDeployResult.h"
#import "GetDeployParams.h"
@interface GetDeployTest : XCTestCase

@end

@implementation GetDeployTest
- (void) getDeploy:(NSString*) jsonString {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"get deploy"];
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = URL_MAIN_NET;
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
            NSLog(@"Error get deploy with error message:%@ and error code:%@",cem.message,cem.code);
        }
       
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
}
- (void) testGetDeploy {
    GetDeployParams * gpr = [[GetDeployParams alloc] init];
    gpr.deploy_hash = @"777253965d76166caba6a4b861a2b4f0bfdfa8bfd46abbcf48f6a1b2cdff02f4";
    //List(Tuple2(Key,U256)
    gpr.deploy_hash = @"afab485f7534d593bf9e30ae34e003d6faf81819a983048b972dbbb4ff441ecc";
    //List(Map(String,String)
    gpr.deploy_hash = @"AaB4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268";
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
    gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    //Transform of type WriteBid and WriteWithdraw
    gpr.deploy_hash = @"acb4d78cbb900fe91a896ea8a427374c5d600cd9206efae2051863316265f1b1";
    //List(Map(String,String)  in session StoredContractByHash
    gpr.deploy_hash = @"a91d468e2ddc8936f7866bc594794b322f747508c2192fd4eca90ef8a121d45e";
    NSString * jsonString = [gpr generatePostParam];
    [self getDeploy:jsonString];
}
@end
