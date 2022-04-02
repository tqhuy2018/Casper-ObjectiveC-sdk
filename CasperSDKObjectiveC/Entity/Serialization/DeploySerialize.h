#ifndef DeploySerialize_h
#define DeploySerialize_h
#import "DeployHeader.h"
#import "Deploy.h"
@interface DeploySerialize:NSObject
+(NSString*) serializeForHeader:(DeployHeader *) header;
+(NSString*) serializeForDeployApproval:(NSMutableArray *) listApprovals;
+(NSString*) serializeForDeploy:(Deploy*) deploy;
@end

#endif
