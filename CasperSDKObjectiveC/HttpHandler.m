#import <Foundation/Foundation.h>
#import "HttpHandler.h"
#import "CasperErrorMessage.h"
#import "ConstValues.h"
#import "GetStateRootHash.h"
#import "GetPeerResult.h"
@implementation HttpHandler
static NSString* casperURL;
+ (NSString*) casperURL
{ @synchronized(self) { return casperURL; } }
+ (void) setCasperURL:(NSString*)val
{ @synchronized(self) { casperURL = val; } }

+(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod {
    HttpHandler.casperURL =  @"https://node-clarity-testnet.make.services/rpc";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.HTTPMethod = @"POST";
    [request setURL:[NSURL URLWithString:HttpHandler.casperURL]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:jsonData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary * forJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        CasperErrorMessage * cem = [[CasperErrorMessage alloc] init];
        [cem fromJsonToErrorObject:forJSONObject];
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            if( rpcMethod == CASPER_RPC_METHOD_GET_STATE_ROOT_HASH) {
               NSString * stateRootHash = [GetStateRootHash fromJsonToStateRootHash:forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_INFO_GET_PEERS) {
                GetPeerResult * gpr =  [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
            }
        } else {
            NSLog(@"Error get state root hash with error message:%@ and error code:%@",cem.message,cem.code);
        }
       }];
    [task resume];
}
@end
