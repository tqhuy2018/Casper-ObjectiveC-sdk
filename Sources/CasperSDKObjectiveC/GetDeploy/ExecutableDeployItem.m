#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_Transfer.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_ModuleBytes.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByHash.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByName.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByHash.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByName.h>
#import <CasperSDKObjectiveC/ConstValues.h>
@implementation ExecutableDeployItem
+(ExecutableDeployItem*) fromJsonDictToExecutableDeployItem:(NSDictionary*) fromDict {
    ExecutableDeployItem * ret = [[ExecutableDeployItem alloc] init];
    ret.itsValue = [[NSMutableArray alloc] init];
    if (!(fromDict[@"ModuleBytes"] == nil)) {
        ret.itsType = EDI_MODULEBYTES;
        ExecutableDeployItem_ModuleBytes * moduleBytes = [[ExecutableDeployItem_ModuleBytes alloc] init];
        moduleBytes = [ExecutableDeployItem_ModuleBytes fromJsonDictToObj:fromDict[@"ModuleBytes"]];
        [ret.itsValue addObject:moduleBytes];
    } else if (!(fromDict[@"StoredContractByHash"] == nil)) {
        ret.itsType = EDI_STORED_CONTRACT_BY_HASH;
        ExecutableDeployItem_StoredContractByHash * s = [[ExecutableDeployItem_StoredContractByHash alloc] init];
        s = [ExecutableDeployItem_StoredContractByHash fromJsonDictToObj:fromDict[@"StoredContractByHash"]];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"StoredContractByName"] == nil)) {
        ret.itsType = EDI_STORED_CONTRACT_BY_NAME;
        ExecutableDeployItem_StoredContractByName * scbn = [[ExecutableDeployItem_StoredContractByName alloc] init];
        [ret.itsValue addObject:scbn];
    } else if (!(fromDict[@"StoredVersionedContractByHash"] == nil)) {
        ret.itsType = EDI_STORED_VERSIONED_CONTRACT_BY_HASH;
        ExecutableDeployItem_StoredVersionedContractByHash * s = [[ExecutableDeployItem_StoredVersionedContractByHash alloc] init];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"StoredVersionedContractByName"] == nil)) {
        ret.itsType = EDI_STORED_VERSIONED_CONTRACT_BY_NAME;
        ExecutableDeployItem_StoredVersionedContractByName * s = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
        [ret.itsValue addObject:s];
    } else if (!(fromDict[@"Transfer"] == nil)) {
        ret.itsType = EDI_TRANSFER;
        ExecutableDeployItem_Transfer * s = [[ExecutableDeployItem_Transfer alloc] init];
        s = [ExecutableDeployItem_Transfer fromJsonDictToObj:fromDict[@"Transfer"]];
        [ret.itsValue addObject:s];
    }
    return ret;
}
/*
-(void) logInfo {
    
    //NSLog(@"ExecutableDeployItem, type:%@",self.itsType);
    if([self.itsType isEqual:EDI_MODULEBYTES]) {
        ExecutableDeployItem_ModuleBytes * moduleBytes = [[ExecutableDeployItem_ModuleBytes alloc] init];
        moduleBytes = (ExecutableDeployItem_ModuleBytes*)[self.itsValue firstObject];
        [moduleBytes logInfo];
    } else  if([self.itsType isEqual:EDI_STORED_CONTRACT_BY_HASH]) {
        ExecutableDeployItem_StoredContractByHash * s = [[ExecutableDeployItem_StoredContractByHash alloc] init];
        s = (ExecutableDeployItem_StoredContractByHash*)[self.itsValue firstObject];
        [s logInfo];
    } else if ([self.itsType isEqual:EDI_TRANSFER]) {
        ExecutableDeployItem_Transfer * s = [[ExecutableDeployItem_Transfer alloc] init];
        s = (ExecutableDeployItem_Transfer*) [self.itsValue firstObject];
        [s logInfo];
    }
}*/
/// This function generate the Json string used for account_put_deploy RPC function call. The returned value of this function is to build up the full deploy
+(NSString*) toJsonString:(ExecutableDeployItem*) fromEDI {
    NSString * ret = @"";
    if([fromEDI.itsType isEqual:EDI_MODULEBYTES]) {
        ExecutableDeployItem_ModuleBytes * moduleBytes = [[ExecutableDeployItem_ModuleBytes alloc] init];
        moduleBytes = (ExecutableDeployItem_ModuleBytes*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:moduleBytes.args];
        NSString * jsonString = [[NSString alloc] initWithFormat:@"{\"module_bytes\": \"%@\",%@}",moduleBytes.module_bytes, runTimeArgsJsonString];
        ret = [[NSString alloc] initWithFormat:@"{\"ModuleBytes\": %@}",jsonString];
        return ret;
    } else if([fromEDI.itsType isEqual:EDI_STORED_CONTRACT_BY_HASH]) {
        ExecutableDeployItem_StoredContractByHash * ediHash = [[ExecutableDeployItem_StoredContractByHash alloc] init];
        ediHash = (ExecutableDeployItem_StoredContractByHash*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:ediHash.args];
        NSString * jsonString = [[NSString alloc] initWithFormat:@"{\"hash\": \"%@\",,\"entry_point\": \"%@\",%@}",ediHash.itsHash, ediHash.entry_point, runTimeArgsJsonString];
        ret = [[NSString alloc] initWithFormat:@"{\"StoredContractByHash\": %@}",jsonString];
        return  ret;
    } else if([fromEDI.itsType isEqual:EDI_STORED_CONTRACT_BY_NAME]) {
        ExecutableDeployItem_StoredContractByName * ediName = [[ExecutableDeployItem_StoredContractByName alloc] init];
        ediName = (ExecutableDeployItem_StoredContractByName*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:ediName.args];
        NSString * jsonString = [[NSString alloc] initWithFormat:@"{\"name\": \"%@\",\"entry_point\": \"%@\",%@}",ediName.name, ediName.entry_point, runTimeArgsJsonString];
        ret = [[NSString alloc] initWithFormat:@"{\"StoredContractByName\": %@}",jsonString];
        return  ret;
    } else if([fromEDI.itsType isEqual:EDI_STORED_VERSIONED_CONTRACT_BY_HASH]) {
        ExecutableDeployItem_StoredVersionedContractByHash * ediVHash = [[ExecutableDeployItem_StoredVersionedContractByHash alloc] init];
        ediVHash = (ExecutableDeployItem_StoredVersionedContractByHash*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:ediVHash.args];
        NSString * jsonString = @"";
        if(ediVHash.is_version_exists) {
            jsonString = [[NSString alloc] initWithFormat:@"{\"hash\": \"%@\",,\"entry_point\": \"%@\", \"version\": \"%u\",%@}",ediVHash.itsHash, ediVHash.entry_point, (unsigned int)ediVHash.version, runTimeArgsJsonString];
        } else {
            jsonString = [[NSString alloc] initWithFormat:@"{\"hash\": \"%@\",,\"entry_point\": \"%@\", \"version\": null,%@}",ediVHash.itsHash, ediVHash.entry_point, runTimeArgsJsonString];
        }
        ret = [[NSString alloc] initWithFormat:@"{\"StoredVersionedContractByHash\": %@}",jsonString];
        return  ret;
    }  else if([fromEDI.itsType isEqual:EDI_STORED_VERSIONED_CONTRACT_BY_NAME]) {
        ExecutableDeployItem_StoredVersionedContractByName * ediVName = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
        ediVName = (ExecutableDeployItem_StoredVersionedContractByName*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:ediVName.args];
        NSString * jsonString = @"";
        if(ediVName.is_version_exists) {
            jsonString = [[NSString alloc] initWithFormat:@"{\"name\": \"%@\",,\"entry_point\": \"%@\", \"version\": \"%u\",%@}",ediVName.name, ediVName.entry_point, (unsigned int)ediVName.version, runTimeArgsJsonString];
        } else {
            jsonString = [[NSString alloc] initWithFormat:@"{\"name\": \"%@\",,\"entry_point\": \"%@\", \"version\": null ,%@}",ediVName.name, ediVName.entry_point,runTimeArgsJsonString];
        }
        ret = [[NSString alloc] initWithFormat:@"{\"StoredVersionedContractByName\": %@}",jsonString];
        return  ret;
    } else if([fromEDI.itsType isEqual:EDI_TRANSFER]) {
        ExecutableDeployItem_Transfer * transfer = [[ExecutableDeployItem_Transfer alloc] init];
        transfer = (ExecutableDeployItem_Transfer*)[fromEDI.itsValue firstObject];
        NSString * runTimeArgsJsonString = [RuntimeArgs toJsonString:transfer.args];
        NSString * jsonString = [[NSString alloc] initWithFormat:@"{%@}",runTimeArgsJsonString];
        ret = [[NSString alloc] initWithFormat:@"{\"Transfer\": %@}",jsonString];
        return ret;
    }
    return ret;
}
@end
