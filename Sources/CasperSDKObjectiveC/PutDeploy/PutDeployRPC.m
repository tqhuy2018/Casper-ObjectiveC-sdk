#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/PutDeployRPC.h>
#import <CasperSDKObjectiveC/Deploy.h>
#import <CasperSDKObjectiveC/Approval.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/CasperErrorMessage.h>
#import <CasperSDKObjectiveC/PutDeployResult.h>
#import <CasperSDKObjectiveC/PutDeployUtils.h>
@implementation PutDeployRPC
-(void) initializeWithRPCURL:(NSString*) url{
    self.casperURL = url;
}
-(void) putDeployForDeploy:(Deploy*) deploy {
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    PutDeployUtils.rpcMethodURL = self.casperURL;
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
    PutDeployUtils.isPutDeploySuccess = true;
    NSData * jsonData = [deployJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                PutDeployResult * ret = [[PutDeployResult alloc] init];
                ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
                PutDeployUtils.putDeployCounter = 0;
                PutDeployUtils.isPutDeploySuccess = true;
                [task resume];
            } else {
                if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                    PutDeployUtils.isPutDeploySuccess = false;
                    [task resume];
                    PutDeployUtils.deploy = deploy;
                    [PutDeployUtils utilsPutDeploy];
                }
            }
        } else {
            
        }
    }];
    [task resume];
}
-(void) putDeployForDeploy:(Deploy*) deploy andCallID:(NSString*) callID {
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    if(PutDeployUtils.putDeployCounter == 0) {
        PutDeployUtils.rpcCallGotResult = [[NSMutableDictionary alloc] init];
        PutDeployUtils.rpcCallGotResult[callID] = RPC_VALUE_NOT_SET;
    }
    PutDeployUtils.rpcMethodURL = self.casperURL;
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
    NSLog(@"deployString:%@",deployJsonString);
    PutDeployUtils.isPutDeploySuccess = true;
    NSData * jsonData = [deployJsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                PutDeployResult * ret = [[PutDeployResult alloc] init];
                ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
                PutDeployUtils.putDeployCounter = 0;
                PutDeployUtils.isPutDeploySuccess = true;
                PutDeployUtils.rpcCallGotResult[callID] = RPC_VALID_RESULT;
                PutDeployUtils.valueDict = [[NSMutableDictionary alloc] init];
                PutDeployUtils.valueDict[callID] = ret;
                PutDeployResult * ret2 = (PutDeployResult*) PutDeployUtils.valueDict[callID];
                [task resume];
            } else {
                if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                    PutDeployUtils.isPutDeploySuccess = false;
                    [task resume];
                     PutDeployUtils.deploy = deploy;
                     [PutDeployUtils utilsPutDeployWithCallID:callID];
                } else {
                    PutDeployUtils.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
                }
            }
        } else {
            PutDeployUtils.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
        }
    }];
    [task resume];
  
}
@end
