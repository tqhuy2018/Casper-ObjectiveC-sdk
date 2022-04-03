#ifndef DeploySerialize_h
#define DeploySerialize_h
#import "DeployHeader.h"
#import "Deploy.h"
/**
 This class do the work of serialize the Deploy object
 */
@interface DeploySerialize:NSObject
+(NSString*) serializeForHeader:(DeployHeader *) header;
+(NSString*) serializeForDeployApproval:(NSMutableArray *) listApprovals;
+(NSString*) serializeForDeploy:(Deploy*) deploy;
@end

#endif
