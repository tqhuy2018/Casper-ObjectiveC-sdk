#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetDeployResult.h>
#import <CasperSDKObjectiveC/Deploy.h>
#import <CasperSDKObjectiveC/JsonExecutionResult.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
#import <CasperSDKObjectiveC/ConstValues.h>
/**Class built for storing GetDeployResult information, taken from info_get_deploy RPC method
 */
@implementation GetDeployResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetDeployResult object
 */
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict {
    GetDeployResult * ret = [[GetDeployResult alloc] init];
    ret.api_version = fromDict[@"api_version"];
    ret.deploy = [Deploy fromJsonDictToDeploy:fromDict[@"deploy"]];
    NSArray * listExecutionResult = (NSArray*) fromDict[@"execution_results"];
    int totalER = (int) listExecutionResult.count;
    ret.execution_results = [[NSMutableArray alloc] init];
    for(int i = 0; i < totalER; i++) {
        JsonExecutionResult * oneItem = [JsonExecutionResult fromJsonDictToJsonExecutionResult:(NSDictionary *) [listExecutionResult objectAtIndex:i]];
        [ret.execution_results addObject:oneItem];
    }
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"id" : 1,"method" : "info_get_deploy","params" : {"deploy_hash" : "6e74f836d7b10dd5db7430497e106ddf56e30afee993dd29b85a91c1cd903583"},"jsonrpc" : "2.0"}
 
 */
+(void) getDeployWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_INFO_GET_DEPLOY];
}
-(void) logInfo {
    NSLog(@"GetDeployResult, api_version:%@",self.api_version);
    [self.deploy logInfo];
    int totalER = (int) self.execution_results.count;

    NSLog(@"EXECUTION_RESULT, Total execution_results:%i",totalER);
    for(int i = 0; i < totalER;i++) {
        NSLog(@"JsonExecutionResult item %i, information",i + 1);
        JsonExecutionResult * item = (JsonExecutionResult*) [self.execution_results objectAtIndex:i];
        [item logInfo];
    }
}
@end
