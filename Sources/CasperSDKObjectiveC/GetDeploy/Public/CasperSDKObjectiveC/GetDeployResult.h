#ifndef GetDeployResult_h
#define GetDeployResult_h
#import <CasperSDKObjectiveC/Deploy.h>
#import <Foundation/Foundation.h>
/**Class built for storing GetDeployResult information, taken from info_get_deploy RPC method
 */
@interface GetDeployResult:NSObject
@property NSString * api_version;
@property Deploy * deploy;
///execution_results of type enum ExecutionResult
@property NSMutableArray * execution_results;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetDeployResult object
 */
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"id" : 1,"method" : "info_get_deploy","params" : {"deploy_hash" : "6e74f836d7b10dd5db7430497e106ddf56e30afee993dd29b85a91c1cd903583"},"jsonrpc" : "2.0"}
 
 */
+(void) getDeployWithParams:(NSString*) jsonString;
@end
#endif 
