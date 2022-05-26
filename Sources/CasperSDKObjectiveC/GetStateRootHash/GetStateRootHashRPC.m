#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetStateRootHashRPC.h>
#import <CasperSDKObjectiveC/GetStateRootHash.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@implementation GetStateRootHashRPC
-(void) setMethodURLTo:(NSString*) url {
    NSLog(@"About to set the method url to :%@",url);
    self.methodURL = url;
    NSLog(@"Done to set the method url to :%@",url);
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
    if(self.methodURL) {
        
    } else {
        self.methodURL = URL_TEST_NET;
    }
    NSLog(@"Send reequest to url:%@",self.methodURL);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:self.methodURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSLog(@"about to get state root hash with this string parameter:%@",jsonString);
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"data back is:%@",forJSONObject);
        CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
        [cem fromJsonToErrorObject:forJSONObject];
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            NSString * state_root_hash = [GetStateRootHash fromJsonToStateRootHash: forJSONObject];
            NSLog(@"State root hash is:%@",state_root_hash);
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
    }];
}
@end
