
#ifndef GetBalanceResult_h
#define GetBalanceResult_h
#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing GetBalanceResult information, taken from state_get_balance RPC method
 */
@interface GetBalanceResult:NSObject
@property NSString * api_version;
@property U512Class * balance_value;
@property NSString * merkle_proof;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetBalanceResult object
 */
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "state_get_balance","id" : 1,"params" :{"state_root_hash" : "8b463b56f2d124f43e7c157e602e31d5d2d5009659de7f1e79afbd238cbaa189","purse_uref":"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007"},"jsonrpc" : "2.0"}
 
 */
+(void) getBalanceWithParams:(NSString*) jsonString;
-(void) logInfo;
@end

#endif
