#ifndef Transform_WriteDeployInfo_h
#define Transform_WriteDeployInfo_h
#import "DeployInfo.h"
#import <Foundation/Foundation.h>
/**Class built for storing Transform_WriteDeployInfo information. This class store Transform enum of type  WriteDeployInfo. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_WriteDeployInfo:NSObject
@property DeployInfo * itsDeployInfo;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transform_WriteDeployInfo object
 */
+(Transform_WriteDeployInfo*) fromJsonDictToTransform_WriteDeployInfo:(NSDictionary*) fromDict;
@end

#endif
