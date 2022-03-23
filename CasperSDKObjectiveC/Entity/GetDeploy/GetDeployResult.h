#ifndef GetDeployResult_h
#define GetDeployResult_h
#import "Deploy.h"
@interface GetDeployResult:NSObject
@property NSString * api_version;
@property Deploy * deploy;
///execution_results of type enum ExecutionResult
@property NSMutableArray * execution_results;
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict;
+(void) getDeployWithParams:(NSString*) jsonString;
-(void) logInfo;
@end
#endif 
