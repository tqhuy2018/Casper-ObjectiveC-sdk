#import <Foundation/Foundation.h>
#import "Transform_WriteDeployInfo.h"
@implementation Transform_WriteDeployInfo
+(Transform_WriteDeployInfo*) fromJsonDictToTransform_WriteDeployInfo:(NSDictionary*) fromDict {
    Transform_WriteDeployInfo * ret = [[Transform_WriteDeployInfo alloc] init];
    ret.itsDeployInfo = [DeployInfo fromJsonDictToDeployInfo:fromDict];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteDeployInfo, information");
    [self.itsDeployInfo logInfo];
}
@end
