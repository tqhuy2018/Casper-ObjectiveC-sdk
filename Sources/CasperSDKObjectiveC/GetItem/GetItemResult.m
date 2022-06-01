#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetItemResult.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for storing GetItemResult information, taken from state_get_item RPC method
 */
@implementation GetItemResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetItemResult object
 */
+(GetItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict{
    GetItemResult * ret = [[GetItemResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    ret.stored_value = [StoredValue fromJsonDictToStoredValue:(NSDictionary *)fromDict[@"stored_value"]];
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 {"method" : "state_get_item","id" : 1,"params" :{"state_root_hash" : "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228","key":"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1","path":[]},"jsonrpc" : "2.0"}
 */
+(void) getItemWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_ITEM];
}
@end
