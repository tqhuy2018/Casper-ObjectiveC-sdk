#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetBalanceResult.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for storing GetBalanceResult information, taken from state_get_balance RPC method
 */
@implementation GetBalanceResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetBalanceResult object
 */
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict {
    GetBalanceResult * ret = [[GetBalanceResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.balance_value = [U512Class fromStrToClass:(NSString *)fromDict[@"balance_value"]];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "state_get_balance","id" : 1,"params" :{"state_root_hash" : "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189","purse_uref":"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007"},"jsonrpc" : "2.0"}
 
 */
+(void) getBalanceWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_BALANCE];
}
@end
