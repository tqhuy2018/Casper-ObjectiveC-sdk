#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Transform_WriteDeployInfo.h>
/**Class built for storing Transform_WriteDeployInfo information. This class store Transform enum of type  WriteDeployInfo. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
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
