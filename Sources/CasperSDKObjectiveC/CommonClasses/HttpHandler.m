#import <Foundation/Foundation.h>
#import "CasperSDKObjectiveC/HttpHandler.h"
#import "CasperSDKObjectiveC/CasperErrorMessage.h"
#import "CasperSDKObjectiveC/ConstValues.h"
//#import "GetStateRootHash.h"
/*#import "GetPeerResult.h"
#import "GetStatusResult.h"
#import "GetDeployResult.h"
#import "GetBlockResult.h"
#import "GetBlockTransfersResult.h"
#import "GetEraInfoResult.h"
#import "GetItemResult.h"
#import "GetDictionaryItemResult.h"
#import "GetBalanceResult.h"
#import "GetAuctionInfoResult.h"
#import "PutDeployResult.h"*/
/**HttpHandler class - Class built for handle POST method of all RPC call
 */
@implementation HttpHandler
static NSString* casperURL;
+ (NSString*) casperURL
{ @synchronized(self) { return casperURL; } }
+ (void) setCasperURL:(NSString*)val
{ @synchronized(self) { casperURL = val; } }
///Function where all the RPC call is handled, with the send of parameter to the POST method and the handle of JSON data back from the server
+(void) handleRequestWithParam:(NSString*) jsonString andRPCMethod:(NSString*) rpcMethod {
    return;
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
        //Check if result back is not error, then parse the JSON back to get corresponding object based on the RPC method all
        if(cem.message == CASPER_ERROR_MESSAGE_NONE) {
            if( rpcMethod == CASPER_RPC_METHOD_GET_STATE_ROOT_HASH) {
              //Uncomment this to get state root hash
               //NSString * stateRootHash = [GetStateRootHash fromJsonToStateRootHash:forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_INFO_GET_PEERS) {
                //Uncomment this to get peer list
               // GetPeerResult * gpr =  [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_INFO_GET_STATUS) {
                //Uncomment this to get status
               // GetStatusResult * gsr = [GetStatusResult fromJsonDictToGetStatusResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_INFO_GET_DEPLOY) {
                //Uncomment this to get deploy
               // GetDeployResult * item = [GetDeployResult fromJsonDictToGetDeployResult:(NSDictionary *)forJSONObject];
            }  else if (rpcMethod == CASPER_RPC_METHOD_CHAIN_GET_BLOCK) {
                //Uncomment this to get block
              //  GetBlockResult * item = [GetBlockResult fromJsonDictToGetBlockResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_CHAIN_GET_BLOCK_TRANSFERS) {
                //Uncomment this to get block transfers
              //  GetBlockTransfersResult * item = [GetBlockTransfersResult fromJsonDictToGetBlockTransfersResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_CHAIN_GET_ERA_BY_SWITCH_BLOCK) {
                //Uncomment this to get era info
               // GetEraInfoResult * item = [GetEraInfoResult fromJsonDictToGetEraInfoResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_STATE_GET_ITEM) {
                //Uncomment this to get item
               // GetItemResult * item = [GetItemResult fromJsonDictToGetItemResult:(NSDictionary *)forJSONObject];
            }  else if (rpcMethod == CASPER_RPC_METHOD_STATE_GET_DICTIONARY_ITEM) {
                //Uncomment this to get dictionary item
               // GetDictionaryItemResult * item = [GetDictionaryItemResult fromJsonDictToGetItemResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_STATE_GET_BALANCE) {
                //Uncomment this to get balance
              //  GetBalanceResult * item = [GetBalanceResult fromJsonDictToGetBalanceResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_STATE_GET_AUCTION_INFO) {
                //Uncomment this to get auction info
               // GetAuctionInfoResult * item = [GetAuctionInfoResult fromJsonDictToGetBalanceResult:(NSDictionary *)forJSONObject];
            } else if (rpcMethod == CASPER_RPC_METHOD_ACCOUNT_PUT_DEPLOY) {
                //Uncomment this to get PutDeployResult object
               // PutDeployResult * item = [PutDeployResult fromJsonObjectToPutDeployResult:(NSDictionary*) forJSONObject];
            }
        } else {
            NSLog(@"Error caught with error message:%@ and error code:%@",cem.message,cem.code);
        }
       }];
    [task resume];
}
@end
