#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByHash.h>
@implementation ExecutableDeployItem_StoredVersionedContractByHash
+(ExecutableDeployItem_StoredVersionedContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_StoredVersionedContractByHash * ret = [[ExecutableDeployItem_StoredVersionedContractByHash alloc] init];
    ret.itsHash = fromDict[@"hash"];
    ret.entry_point = fromDict[@"entry_point"];
    if(![fromDict[@"version"] isEqual:[NSNull null]]) {
        ret.version = [fromDict[@"version"] intValue];
        ret.is_version_exists = true;
    } else {
        ret.is_version_exists = false;
    }
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return ret;
}
/*
-(void) logInfo {
    NSLog(@"ExecutableDeployItem_StoredVersionedContractByHash, hash:%@",self.itsHash);
    NSLog(@"ExecutableDeployItem_StoredVersionedContractByHash, entry_point:%@",self.entry_point);
    if(self.is_version_exists) {
        NSLog(@"ExecutableDeployItem_StoredVersionedContractByHash, version:%u",(unsigned int)self.version);
    } else
    {
        NSLog(@"ExecutableDeployItem_StoredVersionedContractByHash, version does not exist");
    }
    [self.args logInfo];
}*/
@end
