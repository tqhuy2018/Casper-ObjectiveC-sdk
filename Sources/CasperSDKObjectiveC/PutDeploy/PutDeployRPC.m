#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/PutDeployRPC.h>
#import <CasperSDKObjectiveC/Deploy.h>
#import <CasperSDKObjectiveC/Approval.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/PutDeployResult.h>
#import <CasperSDKObjectiveC/PutDeployUtils.h>
@implementation PutDeployRPC
-(void) putDeploy {
    XCTestExpectation * requestExpectation = [self expectationWithDescription:@"put deploy"];
    NSString * casperURL =  URL_TEST_NET;
   // casperURL = @"https://node-clarity-mainnet.make.services/rpc";
    NSString * deployJsonString = [self.params generateParamString];
    Deploy * deploy = self.params.deploy;
    PutDeployUtils.isPutDeploySuccess = true;
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
            PutDeployUtils.putDeployCounter = 0;
            PutDeployUtils.isPutDeploySuccess = true;
        } else {
            NSLog(@"Error put deploy with error message:%@ and error code:%@",cem.message,cem.code);
            if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                PutDeployUtils.isPutDeploySuccess = false;
            }
        }
    }];
    [task resume];
    [self waitForExpectationsWithTimeout:100 handler:^(NSError *error) {
          //  [self closeWithCompletionHandler:nil];
        }];
    if(PutDeployUtils.isPutDeploySuccess == false) {
        PutDeployUtils.putDeployCounter = PutDeployUtils.putDeployCounter + 1;
        NSLog(@"Try to put deploy with Effort:%i",PutDeployUtils.putDeployCounter);
        PutDeployUtils.deploy = deploy;
        [PutDeployUtils utilsPutDeploy];
    }
}
@end
