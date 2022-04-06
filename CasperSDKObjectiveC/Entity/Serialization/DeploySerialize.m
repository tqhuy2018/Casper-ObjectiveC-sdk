#import <Foundation/Foundation.h>
#import "DeploySerialize.h"
#import "CLParseSerializeHelper.h"
#import "CLTypeSerializeHelper.h"
#import "Utils.h"
#import "ConstValues.h"
#import "Approval.h"
#import "ExecutableDeployItemSerializationHelper.h"
@implementation DeploySerialize
/**
 Serialization for the Deploy Header
 Rule for serialization:
 Returned result = deployHeader.account + U64.serialize(deployHeader.timeStampMiliSecondFrom1970InU64) + U64.serialize(deployHeader.ttlMilisecondsFrom1980InU64) + U64.serialize(gas_price) + deployHeader.bodyHash
 */
+(NSString*) serializeForHeader:(DeployHeader *) header {
    NSString * ret = @"";
    UInt64 timeStamp64 = [Utils fromTimeStampToU64Str:header.timestamp];
    UInt64 ttl64 = [Utils fromTimeToLiveToU64Str:header.ttl];
    NSString * timeStampStr = [NSString stringWithFormat:@"%llu",timeStamp64];
    NSString * ttlStr = [NSString stringWithFormat:@"%llu",ttl64];
    CLParsed * parseTimeStamp = [[CLParsed alloc] init];
    parseTimeStamp.itsValueStr = timeStampStr;
    parseTimeStamp.itsCLTypeStr = CLTYPE_U64;
    NSString * timeStampSerialization = [CLParseSerializeHelper serializeFromCLParseU64:parseTimeStamp];
    CLParsed * parseTTL = [[CLParsed alloc] init];
    parseTTL.itsValueStr = ttlStr;
    parseTTL.itsCLTypeStr = CLTYPE_U64;
    NSString * ttlSerialization = [CLParseSerializeHelper serializeFromCLParseU64:parseTTL];
    CLParsed * parseGasPrice = [[CLParsed alloc] init];
    parseGasPrice.itsValueStr = [NSString stringWithFormat:@"%llu",header.gas_price];
    parseGasPrice.itsCLTypeStr = CLTYPE_U64;
    NSString * gasPriceSerialization = [CLParseSerializeHelper serializeFromCLParseU64:parseGasPrice];
    NSString * dependencySerialization = @"";
    int totalDependency = (int) header.dependencies.count;
    CLParsed * dependencySizeParse = [[CLParsed alloc] init];
    dependencySizeParse.itsValueStr = [NSString stringWithFormat:@"%i",totalDependency];
    dependencySizeParse.itsCLTypeStr = CLTYPE_U32;
    dependencySerialization = [CLParseSerializeHelper serializeFromCLParseU32:dependencySizeParse];
    if (totalDependency>0) {
        for (int i = 0 ; i < totalDependency ; i++) {
            NSString * d = (NSString*) [header.dependencies objectAtIndex:i];
            dependencySerialization = [NSString stringWithFormat:@"%@%@",dependencySerialization,d];
        }
    }
    CLParsed * chainNameParse = [[CLParsed alloc] init];
    chainNameParse.itsValueStr = header.chain_name;
    chainNameParse.itsCLTypeStr = CLTYPE_STRING;
    NSString * chainNameSerialize = [CLParseSerializeHelper serializeFromCLParseString:chainNameParse];
    ret = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",header.account,timeStampSerialization,ttlSerialization,gasPriceSerialization,header.body_hash,dependencySerialization,chainNameSerialize];
    return ret;
}
/**
 Serialization for the Deploy Approvals
 Rule for serialization:
 If the approval list is empty, just return "00000000", which is equals to U32.serialize(0)
 If the approval list is not empty, then first get the approval list length, then take the prefixStr = U32.serialize(approvalList.length)
 Then concatenate all the elements in the approval list with rule for each element:
 1 element serialization = singer + signature
 Final result = prefix + (list.serialize)
 */
+(NSString*) serializeForDeployApproval:(NSMutableArray *) listApprovals {
    NSString * ret = @"";
    int totalApproval = (int)[listApprovals count];
    if (totalApproval == 0) {
        return @"00000000";
    }
    CLParsed * parse32 = [[CLParsed alloc] init];
    parse32.itsValueStr = [NSString stringWithFormat:@"%i",totalApproval];
    parse32.itsCLTypeStr = CLTYPE_U32;
    NSString * prefix = (NSString*) [CLParseSerializeHelper serializeFromCLParseU32:parse32];
    NSString * listApprovalSerializeStr = @"";
    for(int i = 0 ; i < totalApproval; i ++) {
        Approval * oneA = [listApprovals objectAtIndex:i];
        listApprovalSerializeStr = [NSString stringWithFormat:@"%@%@%@",listApprovalSerializeStr,oneA.signer,oneA.signature];
    }
    ret = [NSString stringWithFormat:@"%@%@",prefix,listApprovalSerializeStr];
    return ret;
}
/**
 This function do the serialization for a full deploy, with rule for serialization like this:
 result = deployHeader.serialize + deploy.hash + deployPayment.serialize + deploySession.serialize + deployApprovals.serialize
 */
+(NSString*) serializeForDeploy:(Deploy*) deploy {
    NSString * ret = @"";
    ret = [DeploySerialize serializeForHeader:deploy.header];
    ret = [NSString stringWithFormat:@"%@%@",ret,deploy.itsHash];
    NSString * paymentSerialization = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:deploy.payment];
    NSString * sessionSerialization = [ExecutableDeployItemSerializationHelper serializeForExecutableDeployItem:deploy.session];
    NSString * approvalSerialization = [DeploySerialize serializeForDeployApproval:deploy.approvals];
    ret = [NSString stringWithFormat:@"%@%@%@%@",ret,paymentSerialization,sessionSerialization,approvalSerialization];
    return ret;
}
@end
