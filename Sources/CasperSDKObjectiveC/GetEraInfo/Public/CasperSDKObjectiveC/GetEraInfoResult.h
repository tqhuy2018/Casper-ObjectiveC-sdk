#ifndef GetEraInfoResult_h
#define GetEraInfoResult_h
#import "EraSummary.h"
#import <Foundation/Foundation.h>
/**Class built for storing GetEraInfoResult information, taken from chain_get_era_info_by_switch_block RPC method
 */
@interface GetEraInfoResult:NSObject
@property NSString * api_version;
///EraSummary value which is optional
@property EraSummary * era_summary;
///Bool value to check whether the era_summary exist or not
@property bool is_era_summary_existed;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetEraInfoResult object
 */
+(GetEraInfoResult*) fromJsonDictToGetEraInfoResult:(NSDictionary*) fromDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "chain_get_era_info_by_switch_block","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 */
+(void) getEraInfoWithParams:(NSString*) jsonString;
-(void)logInfo;
@end

#endif 
