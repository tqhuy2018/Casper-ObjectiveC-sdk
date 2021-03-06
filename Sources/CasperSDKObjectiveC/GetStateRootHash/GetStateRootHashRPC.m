#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetStateRootHashRPC.h>
#import <CasperSDKObjectiveC/GetStateRootHash.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@implementation GetStateRootHashRPC
@synthesize casperURL;
-(void) initializeWithRPCURL:(NSString*) url{
    self.casperURL = url;
    self.valueDict = [[NSMutableDictionary alloc] init];
}

/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
{"params" : [],"id" : 1,"method":"chain_get_state_root_hash","jsonrpc" : "2.0"}
 if you wish to send without any param along with the RPC call
 
or:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 if you wish to send the block hash along with the POST method in the RPC call
 
 or:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Height" :100}},"jsonrpc" : "2.0"}
 if you wish to send the block height along with the POST method in the RPC call
 
 */
-(void) getStateRootHashWithJsonParam:(NSString*) jsonString {
    if(self.casperURL) {
        NSLog(@"Casper url is set to this value:%@",self.casperURL);
    } else {
        NSLog(@"Casper url is not set to anyvalue and aout to set to test net");
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
                NSString * stateRootHash = [GetStateRootHash fromJsonToStateRootHash:forJSONObject];
            } else {
                NSLog(@"Error caught with error message:%@ and error code:%@",cem.message,cem.code);
            }
        } else {
            NSLog(@"Error http request");
        }
       }];
    [task resume];
}
-(void) getStateRootHashWithJsonParam2:(NSString*) jsonString andCallID:(NSString*) callID {
    self.valueDict[callID] = RPC_VALUE_NOT_SET;
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
                NSString * stateRootHash = [GetStateRootHash fromJsonToStateRootHash:forJSONObject];
                self.valueDict[callID] = stateRootHash;
            } else {
                self.valueDict[callID] = RPC_VALUE_ERROR_OBJECT;
            }
        } else {
            self.valueDict[callID] = RPC_VALUE_ERROR_NETWORK;
        }
       }];
    [task resume];
}
@end
