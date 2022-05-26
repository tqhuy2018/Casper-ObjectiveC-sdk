#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetBlockTransfersRPC.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/GetBlockTransfersResult.h>
@implementation GetBlockTransfersRPC
-(void) initializeWithRPCURL:(NSString*) url{
    self.casperURL = url;
    self.valueDict = [[NSMutableDictionary alloc] init];
    self.rpcCallGotResult = [[NSMutableDictionary alloc] init];
}
-(void) getBlockTransfersWithJsonParam:(NSString*) jsonString {
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary * forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            //Check if result back is not error, then parse the JSON back to get corresponding object based on the RPC method all
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                self.rpcCallGotResult[self.callID] = RPC_VALID_RESULT;
                GetBlockTransfersResult * item = [[GetBlockTransfersResult alloc] init];
                item = [GetBlockTransfersResult fromJsonDictToGetBlockTransfersResult:forJSONObject[@"result"]];
                self.valueDict[self.callID] = item;
            } else {
                self.rpcCallGotResult[self.callID] = RPC_VALUE_ERROR_OBJECT;
            }
        } else {
            self.rpcCallGotResult[self.callID] = RPC_VALUE_ERROR_NETWORK;
        }
       }];
    [task resume];
}
-(void) getBlockTransfersWithJsonParam2:(NSString*) jsonString andCallID:(NSString*) callID {
    self.rpcCallGotResult[callID] = RPC_VALUE_NOT_SET;
    if(self.casperURL) {
    } else {
        self.casperURL = URL_TEST_NET;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSDictionary * forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
            [cem fromJsonToErrorObject:forJSONObject];
            //Check if result back is not error, then parse the JSON back to get corresponding object based on the RPC method all
            if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
                GetBlockTransfersResult * item = [[GetBlockTransfersResult alloc] init];
                item = [GetBlockTransfersResult fromJsonDictToGetBlockTransfersResult:forJSONObject[@"result"]];
                self.valueDict[callID] = item;
                self.rpcCallGotResult[callID] = RPC_VALID_RESULT;
            } else {
                self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_OBJECT;
            }
        } else {
            self.rpcCallGotResult[callID] = RPC_VALUE_ERROR_NETWORK;
        }
       }];
    [task resume];
}
@end
