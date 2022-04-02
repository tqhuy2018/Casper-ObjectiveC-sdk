#import <Foundation/Foundation.h>
#import "DeploySerialize.h"
@implementation DeploySerialize
+(NSString*) serializeForHeader:(DeployHeader *) header {
    NSString * ret = @"";
    /*var retStr =  from.account +  CLTypeSerializeHelper.UInt64Serialize(input:Utils.dateStrToMilisecond(dateStr:from.timestamp)) + CLTypeSerializeHelper.UInt64Serialize(input: Utils.ttlToMilisecond(ttl: from.ttl)) + CLTypeSerializeHelper.UInt64Serialize(input: from.gas_price) + from.body_hash*/
    ret = header.account;
   // NSString * timeStampIn64 = 
    return ret;
}
+(NSString*) serializeForDeployApproval:(NSMutableArray *) listApprovals {
    NSString * ret = @"";
    return ret;
}
+(NSString*) serializeForDeploy:(Deploy*) deploy {
    NSString * ret = @"";
    return ret;
}
@end
