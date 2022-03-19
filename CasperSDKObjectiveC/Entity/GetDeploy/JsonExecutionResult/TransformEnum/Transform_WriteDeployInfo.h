#ifndef Transform_WriteDeployInfo_h
#define Transform_WriteDeployInfo_h
#import "DeployInfo.h"
@interface Transform_WriteDeployInfo:NSObject
@property DeployInfo * itsDeployInfo;
+(Transform_WriteDeployInfo*) fromJsonDictToTransform_WriteDeployInfo:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
