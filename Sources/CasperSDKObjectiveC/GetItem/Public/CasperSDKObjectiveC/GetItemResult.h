#ifndef GetItemResult_h
#define GetItemResult_h
#import <CasperSDKObjectiveC/StoredValue.h>
#import <Foundation/Foundation.h>
/**Class built for storing GetItemResult information, taken from state_get_item RPC method
 */
@interface GetItemResult:NSObject
@property NSString * api_version;
@property NSString * merkle_proof;
@property StoredValue * stored_value;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetItemResult object
 */
+(GetItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 {"method" : "state_get_item","id" : 1,"params" :{"state_root_hash" : "d360e2755f7cee816cce3f0eeb2000dfa03113769743ae5481816f3983d5f228","key":"withdraw-df067278a61946b1b1f784d16e28336ae79f48cf692b13f6e40af9c7eadb2fb1","path":[]},"jsonrpc" : "2.0"}
 */
+(void) getItemWithParams:(NSString*) jsonString;
@end

#endif 
