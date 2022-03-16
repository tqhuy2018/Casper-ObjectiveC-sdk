#import <Foundation/Foundation.h>
#import "GetDeployResult.h"
#import "Deploy.h"
@implementation GetDeployResult
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict {
    GetDeployResult * ret = [[GetDeployResult alloc] init];
    ret.api_version = fromDict[@"api_version"];
    ret.deploy = [Deploy fromJsonDictToDeploy:fromDict[@"deploy"]];
    return ret;
}
@end
