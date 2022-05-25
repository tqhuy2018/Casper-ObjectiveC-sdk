#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredVersionedContractByName.h>
@implementation ExecutableDeployItem_StoredVersionedContractByName
+(ExecutableDeployItem_StoredVersionedContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_StoredVersionedContractByName * ret = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
    
    if(![fromDict[@"version"] isEqual:[NSNull null]]) {
        ret.version = [fromDict[@"version"] intValue];
        ret.is_version_exists = true;
    } else {
        ret.is_version_exists = false;
    }
    ret.name = fromDict[@"name"];
    ret.entry_point = fromDict[@"entry_point"];
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return  ret;
}
-(void) logInfo {
    NSLog(@"ExecutableDeployItem_StoredVersionedContractByName, name:%@",self.name);
    NSLog(@"ExecutableDeployItem_StoredVersionedContractByName, entry_point:%@",self.entry_point);
    if(self.is_version_exists) {
        NSLog(@"ExecutableDeployItem_StoredVersionedContractByName, version:%u",(unsigned int)self.version);
    } else
    {
        NSLog(@"ExecutableDeployItem_StoredVersionedContractByName, version does not exist");
    }
    [self.args logInfo];
}
@end
