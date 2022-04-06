#ifndef DeploySerialize_h
#define DeploySerialize_h
#import "DeployHeader.h"
#import "Deploy.h"
/**
 This class do the work of serialize the Deploy object
 */
@interface DeploySerialize:NSObject
/**
 Serialization for the Deploy Header
 Rule for serialization:
 Returned result = deployHeader.account + U64.serialize(deployHeader.timeStampMiliSecondFrom1970InU64) + U64.serialize(deployHeader.ttlMilisecondsFrom1980InU64) + U64.serialize(gas_price) + deployHeader.bodyHash
 */
+(NSString*) serializeForHeader:(DeployHeader *) header;
/**
 Serialization for the Deploy Approvals
 Rule for serialization:
 If the approval list is empty, just return "00000000", which is equals to U32.serialize(0)
 If the approval list is not empty, then first get the approval list length, then take the prefixStr = U32.serialize(approvalList.length)
 Then concatenate all the elements in the approval list with rule for each element:
 1 element serialization = singer + signature
 Final result = prefix + (list.serialize)
 */
+(NSString*) serializeForDeployApproval:(NSMutableArray *) listApprovals;
/**
 This function do the serialization for a full deploy, with rule for serialization like this:
 result = deployHeader.serialize + deploy.hash + deployPayment.serialize + deploySession.serialize + deployApprovals.serialize
 */
+(NSString*) serializeForDeploy:(Deploy*) deploy;
@end

#endif
