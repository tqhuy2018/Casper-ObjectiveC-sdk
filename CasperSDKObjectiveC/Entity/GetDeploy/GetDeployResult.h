#ifndef GetDeployResult_h
#define GetDeployResult_h
#import "Deploy.h"
@interface GetDeployResult:NSObject
@property NSString * api_version;
@property Deploy * deploy;
@property NSMutableArray * execution_results;
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict;
-(void) logInfo;
@end
#endif 
