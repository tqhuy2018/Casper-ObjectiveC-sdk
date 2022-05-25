#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/TransformEntry.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/Transform_WriteCLValue.h>
#import <CasperSDKObjectiveC/Transform_WriteBid.h>
#import <CasperSDKObjectiveC/Transform_WriteDeployInfo.h>
#import <CasperSDKObjectiveC/Transform_WriteEraInfo.h>
#import <CasperSDKObjectiveC/Transform_WriteTransfer.h>
#import <CasperSDKObjectiveC/Transform_WriteWithdraw.h>
#import <CasperSDKObjectiveC/Transform_AddKeys.h>
/**Class built for storing TransformEntry information
 */
@implementation TransformEntry
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to TransformEntry object
 */
+(TransformEntry*) fromJsonDictToTransformEntry:(NSDictionary*) fromDict {
    TransformEntry * ret = [[TransformEntry alloc] init];
    ret.key = (NSString*) fromDict[@"key"];
   // NSLog(@"transform:%@",fromDict[@"transform"]);
    NSObject * obj = fromDict[@"transform"];
    if([obj isKindOfClass:[NSString class]]) {
        //Get transform of raw type: Identity,WriteContractWasm,WriteContract,WriteContractPackage
        if([fromDict[@"transform"] isEqualToString: TRANSFORM_IDENTITY]) {
            ret.transformType = TRANSFORM_IDENTITY;
        } else if([fromDict[@"transform"] isEqualToString: TRANSFORM_WRITE_CONTRACT_WASM]) {
            ret.transformType = TRANSFORM_WRITE_CONTRACT_WASM;
        } else if([fromDict[@"transform"] isEqualToString: TRANSFORM_WRITE_CONTRACT]) {
            ret.transformType = TRANSFORM_WRITE_CONTRACT;
        } else if([fromDict[@"transform"] isEqualToString: TRANSFORM_WRITE_CONTRACT_PACKAGE]) {
            ret.transformType = TRANSFORM_WRITE_CONTRACT_PACKAGE;
        }
    } else {
        NSDictionary * transformDict = (NSDictionary*) fromDict[@"transform"];
        ret.transform = [[NSMutableArray alloc] init];
        //Transform of type WriteCLValue
        if(!(transformDict[@"WriteCLValue"] == nil)) {
            ret.transformType = TRANSFORM_WRITE_CLVALUE;
            Transform_WriteCLValue * twv = [[Transform_WriteCLValue alloc] init];
            twv = [Transform_WriteCLValue fromJsonDictToTransform_WriteCLValue: (NSDictionary*)  transformDict[@"WriteCLValue"]];
            [ret.transform addObject:twv];
        } else if(!(transformDict[@"WriteAccount"] == nil)) {
            ret.transformType = TRANSFORM_WRITE_ACCOUNT;
            [ret.transform addObject:(NSString*) transformDict[@"WriteAccount"]];
        }else if(!(transformDict[@"WriteDeployInfo"] == nil)) {
            ret.transformType = TRANSFORM_WRITE_DEPLOY_INFO;
            Transform_WriteDeployInfo * item = [[Transform_WriteDeployInfo alloc] init];
            item = [Transform_WriteDeployInfo fromJsonDictToTransform_WriteDeployInfo: (NSDictionary*)  transformDict[@"WriteDeployInfo"]];
            [ret.transform addObject:item];
        } else if (!(transformDict[@"WriteEraInfo"] ==nil)) {
            ret.transformType = TRANSFORM_WRITE_ERA_INFO;
            Transform_WriteEraInfo * item = [[Transform_WriteEraInfo alloc] init];
            item = [Transform_WriteEraInfo fromJsonArrayToTransform_WriteEraInfo:(NSArray*)transformDict[@"WriteEraInfo"]];
            [ret.transform addObject:item];
        } else if (!(transformDict[@"WriteTransfer"] ==nil)) {
            ret.transformType = TRANSFORM_WRITE_TRANSFER;
            Transform_WriteTransfer * item = [[Transform_WriteTransfer alloc] init];
            item = [Transform_WriteTransfer fromJsonDictToTransform_WriteTransfer:(NSDictionary*) transformDict[@"WriteTransfer"]];
            [ret.transform addObject:item];
        } else if (!(transformDict[@"WriteBid"] ==nil)) {
            ret.transformType = TRANSFORM_WRITE_BID;
            Transform_WriteBid * item = [[Transform_WriteBid alloc] init];
            item = [Transform_WriteBid fromJsonDictToTransform_WriteBid:(NSDictionary*) transformDict[@"WriteBid"]];
            [ret.transform addObject:item];
        } else if (!(transformDict[@"WriteWithdraw"] ==nil)) {
            ret.transformType = TRANSFORM_WRITE_WITHDRAW;
            Transform_WriteWithdraw * item = [[Transform_WriteWithdraw alloc] init];
            item = [Transform_WriteWithdraw fromJsonArrayToTransform_WriteWithdraw:(NSArray*) transformDict[@"WriteWithdraw"]];
            [ret.transform addObject:item];
        } else if (!(transformDict[@"AddKeys"] == nil)) {
            ret.transformType = TRANSFORM_ADD_KEYS;
            Transform_AddKeys * item = [[Transform_AddKeys alloc] init];
            item = [Transform_AddKeys fromJSonArrayToTransform_AddKeys:(NSArray *) transformDict[@"AddKeys"] ];
            [ret.transform addObject:item];
        } else if(!(transformDict[@"AddInt32"] == nil)) {
            ret.transformType = TRANSFORM_ADD_INT32;
            [ret.transform addObject:(NSString*)transformDict[@"AddInt32"]];
        } else if (!(transformDict[@"AddUInt64"] == nil)) {
            [ret.transform addObject:(NSString*) transformDict[@"AddUInt64"]];
            ret.transformType = TRANSFORM_ADD_UINT64;
        } else if (!(transformDict[@"AddUInt128"] == nil)) {
            [ret.transform addObject: (NSString*) transformDict[@"AddUInt128"]];
            ret.transformType = TRANSFORM_ADD_UINT128;
        } else if (!(transformDict[@"AddUInt256"] == nil)) {
            [ret.transform addObject : (NSString*) transformDict[@"AddUInt256"] ];
            ret.transformType = TRANSFORM_ADD_UINT256;
        } else if (!(transformDict[@"AddUInt512"] == nil)) {
            [ret.transform addObject:  (NSString*) transformDict[@"AddUInt512"]];
            ret.transformType = TRANSFORM_ADD_UINT512;
        } else if(!(transformDict[@"Failure"] == nil)) {
            ret.transformType = TRANSFORM_FAILURE;
            [ret.transform addObject:(NSString*) transformDict[@"Failure"]];
        }
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"TransformEntry, key:%@",self.key);
    NSLog(@"TransformEntry,type:%@",self.transformType);
    //Log for Transform of complex result
    if ([self.transformType isEqualToString:TRANSFORM_FAILURE]) {
        NSLog(@"TransformEntry_Failure, string:%@",(NSString*) [self.transform objectAtIndex:0]);
    } else if([self.transformType isEqualToString:TRANSFORM_ADD_KEYS]) {
        Transform_AddKeys * item = (Transform_AddKeys*) [self.transform objectAtIndex:0];
        [item logInfo];
    } else if([self.transformType isEqualToString:TRANSFORM_WRITE_BID]) {
        Transform_WriteBid * item = (Transform_WriteBid*) [self.transform objectAtIndex:0];
        [item logInfo];
    } else if ([self.transformType isEqualToString:TRANSFORM_WRITE_CLVALUE]) {
        Transform_WriteCLValue * item = (Transform_WriteCLValue*) [self.transform objectAtIndex:0];
        [item logInfo];
    } else if ([self.transformType isEqualToString:TRANSFORM_WRITE_WITHDRAW]) {
        Transform_WriteWithdraw * item = (Transform_WriteWithdraw*) [self.transform objectAtIndex:0];
        [item logInfo];
    } else if([self.transformType isEqualToString:TRANSFORM_WRITE_ERA_INFO]) {
        Transform_WriteEraInfo * item = (Transform_WriteEraInfo*)[self.transform objectAtIndex:0];
        [item logInfo];
    } else if([self.transformType isEqualToString:TRANSFORM_WRITE_TRANSFER]) {
        Transform_WriteTransfer * item = (Transform_WriteTransfer*)[self.transform objectAtIndex:0];
        [item logInfo];
    } else if([self.transformType isEqualToString:TRANSFORM_WRITE_DEPLOY_INFO]) {
        Transform_WriteDeployInfo * item = (Transform_WriteDeployInfo*)[self.transform objectAtIndex:0];
        [item logInfo];
    } else if ([self.transformType isEqualToString:TRANSFORM_WRITE_ACCOUNT]) {
        NSLog(@"TransformEntry_WriteAccount, account hash:%@",(NSString*) [self.transform objectAtIndex:0]);
    }
}
@end
