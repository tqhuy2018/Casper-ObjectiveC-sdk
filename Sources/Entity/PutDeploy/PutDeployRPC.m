#import <Foundation/Foundation.h>
#import "PutDeployRPC.h"
#import "Deploy.h"
#import "Approval.h"
#import "ConstValues.h"
#import "CasperErrorMessage.h"
#import "PutDeployResult.h"
#import "Utils.h"
@implementation PutDeployRPC
-(void) putDeploy {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"put deploy"];
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = @"https://node-clarity-mainnet.make.services/rpc";
    NSString * deployJsonString = [self.params generateParamString];
    Deploy * deploy = self.params.deploy;
    Utils.isPutDeploySuccess = true;
    NSLog(@"Put deploy, deploy hash is:%@",deploy.itsHash);
    NSLog(@"Put deploy full is:%@",deployJsonString);
    NSData * jsonData = [deployJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [requestExpectation fulfill];
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
        [cem fromJsonToErrorObject:forJSONObject];
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            PutDeployResult * ret = [[PutDeployResult alloc] init];
            ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
            NSLog(@"Put deploy success with deploy hash:%@",ret.deployHash);
            Utils.putDeployCounter = 0;
            Utils.isPutDeploySuccess = true;
        } else {
            NSLog(@"Error put deploy with error message:%@ and error code:%@",cem.message,cem.code);
            if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                Utils.isPutDeploySuccess = false;
            }
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
    if(Utils.isPutDeploySuccess == false) {
        Utils.putDeployCounter = Utils.putDeployCounter + 1;
        NSLog(@"Try to put deploy with Effort:%i",Utils.putDeployCounter);
        Utils.deploy = deploy;
        [Utils utilsPutDeploy];
    }
}
@end
