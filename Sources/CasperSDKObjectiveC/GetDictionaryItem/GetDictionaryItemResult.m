#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetDictionaryItemResult.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for storing GetDictionaryItemResult information, taken from state_get_dictionary_item RPC method
 */
@implementation GetDictionaryItemResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetDictionaryItemResult object
 */
+(GetDictionaryItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict {
    GetDictionaryItemResult * ret = [[GetDictionaryItemResult alloc] init];
    ret.api_version = (NSString* ) fromDict[@"api_version"];
    ret.dictionary_key = (NSString*) fromDict[@"dictionary_key"];
    ret.merkle_proof = (NSString *) fromDict[@"merkle_proof"];
    ret.stored_value = [StoredValue fromJsonDictToStoredValue:(NSDictionary*) fromDict[@"stored_value"]];
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "state_get_dictionary_item","id" : 1,"params" :{"state_root_hash" : "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8","dictionary_identifier":{"AccountNamedKey":{"dictionary_name":"dict_name","key":"account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877","dictionary_item_key":"abc_name"}}},"jsonrpc" : "2.0"}
 
 */
+(void) getDictionaryItemWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_DICTIONARY_ITEM];
}
@end
