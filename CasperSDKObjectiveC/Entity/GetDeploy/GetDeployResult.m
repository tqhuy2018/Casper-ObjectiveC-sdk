#import <Foundation/Foundation.h>
#import "GetDeployResult.h"
#import "Deploy.h"
#import "JsonExecutionResult.h"
#import "HttpHandler.h"
#import "ConstValues.h"
@implementation GetDeployResult
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
