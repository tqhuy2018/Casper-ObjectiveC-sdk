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
    //self.valueDict = [[NSMutableDictionary alloc] init];
    //self.rpcCallGotResult = [[NSMutableDictionary alloc] init];
}
-(void) putDeployForDeploy:(Deploy*) deploy {
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    PutDeployUtils.rpcMethodURL = self.casperURL;
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
    //Deploy * deploy = self.params.deploy;
    PutDeployUtils.isPutDeploySuccess = true;
    NSLog(@"Put deploy, deploy hash is:%@",deploy.itsHash);
    NSLog(@"Put deploy full is:%@",deployJsonString);
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
                NSLog(@"Put deploy success with deploy hash:%@",ret.deployHash);
                PutDeployUtils.putDeployCounter = 0;
                PutDeployUtils.isPutDeploySuccess = true;
                [task resume];
            } else {
                NSLog(@"Error put deploy with error message:%@ and error code:%@",cem.message,cem.code);
                if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                    PutDeployUtils.isPutDeploySuccess = false;
                    [task resume];
                    PutDeployUtils.putDeployCounter = PutDeployUtils.putDeployCounter + 1;
                    NSLog(@"Try to put deploy with Effort:%i",PutDeployUtils.putDeployCounter);
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
    //self.rpcCallGotResult[callID] = RPC_VALUE_NOT_SET;
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    PutDeployUtils.rpcMethodURL = self.casperURL;
    NSString * deployJsonString = [deploy toPutDeployParameterStr];
    PutDeployUtils.isPutDeploySuccess = true;
    NSLog(@"Put deploy, deploy hash is:%@ and url is:%@",deploy.itsHash,self.casperURL);
    NSLog(@"Put deploy full is:%@",deployJsonString);
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
            NSLog(@"After putting,  value back is:%@",forJSONObject);
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                PutDeployResult * ret = [[PutDeployResult alloc] init];
                ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
                NSLog(@"Put deploy success with deploy hash:%@",ret.deployHash);
                PutDeployUtils.putDeployCounter = 0;
                PutDeployUtils.isPutDeploySuccess = true;
                PutDeployUtils.rpcCallGotResult[callID] = RPC_VALID_RESULT;
                PutDeployUtils.valueDict[callID] = ret;
                PutDeployResult * ret2 = (PutDeployResult*) PutDeployUtils.valueDict[callID];
                NSLog(@"Put deploy success with Deploy hash 2:%@",ret2.deployHash);
                [task resume];
            } else {
                NSLog(@"Error put deploy with error message:%@ and error code:%@",cem.message,cem.code);
                if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                    PutDeployUtils.isPutDeploySuccess = false;
                    [task resume];
                     PutDeployUtils.putDeployCounter = PutDeployUtils.putDeployCounter + 1;
                     NSLog(@"Try to put deploy with Effort:%i",PutDeployUtils.putDeployCounter);
                     PutDeployUtils.deploy = deploy;
                     [PutDeployUtils utilsPutDeployWithCallID:callID];
                } else {
                    //self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
                    PutDeployUtils.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
                    NSLog(@"Error put wrong value");
                }
            }
        } else {
           // self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
            PutDeployUtils.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
            NSLog(@"Error because of network");
        }
    }];
    [task resume];
   /* if(PutDeployUtils.isPutDeploySuccess == false) {
        PutDeployUtils.putDeployCounter = PutDeployUtils.putDeployCounter + 1;
        NSLog(@"Try to put deploy with Effort:%i",PutDeployUtils.putDeployCounter);
        PutDeployUtils.deploy = deploy;
        [PutDeployUtils utilsPutDeploy];
    } else {
        NSLog(@"Task done successfully, no need to do anything more");
    }*/
}
/*
-(void) putDeployWithJsonString:(NSString*) putDeployString andCallID:(NSString*) callID {
    self.rpcCallGotResult[callID] = RPC_VALUE_NOT_SET;
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    //NSString * deployJsonString = [deploy toPutDeployParameterStr];
    PutDeployUtils.isPutDeploySuccess = true;
    NSLog(@"Put deploy full is:%@",putDeployString);
    NSData * jsonData = [putDeployString dataUsingEncoding:NSUTF8StringEncoding];
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
            NSLog(@"After putting,  value back is:%@",forJSONObject);
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                PutDeployResult * ret = [[PutDeployResult alloc] init];
                ret = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject[@"result"]];
                NSLog(@"Put deploy success with deploy hash:%@",ret.deployHash);
                PutDeployUtils.putDeployCounter = 0;
                PutDeployUtils.isPutDeploySuccess = true;
                self.rpcCallGotResult[callID] = RPC_VALID_RESULT;
                self.valueDict[callID] = ret;
            } else {
                NSLog(@"Error put deploy with error message:%@ and error code:%@",cem.message,cem.code);
                if([cem.message isEqualToString: @"invalid deploy: the approval at index 0 is invalid: asymmetric key error: failed to verify secp256k1 signature: signature error"]) {
                    PutDeployUtils.isPutDeploySuccess = false;
                } else {
                    self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
                    NSLog(@"Error put wrong value");
                }
            }
        } else {
            self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
            NSLog(@"Error because of network");
        }
    }];
    [task resume];
    if(PutDeployUtils.isPutDeploySuccess == false) {
       // PutDeployUtils.putDeployCounter = PutDeployUtils.putDeployCounter + 1;
        NSLog(@"Try to put deploy with Effort:%i",PutDeployUtils.putDeployCounter);
        //PutDeployUtils.deploy = deploy;
       // [PutDeployUtils utilsPutDeploy];
    }
}*/
@end
