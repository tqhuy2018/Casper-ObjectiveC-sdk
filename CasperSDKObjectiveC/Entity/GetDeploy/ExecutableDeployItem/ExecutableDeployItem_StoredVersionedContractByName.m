#import <Foundation/Foundation.h>
#import "ExecutableDeployItem_StoredVersionedContractByName.h"
@implementation ExecutableDeployItem_StoredVersionedContractByName
+(ExecutableDeployItem_StoredVersionedContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_StoredVersionedContractByName * ret = [[ExecutableDeployItem_StoredVersionedContractByName alloc] init];
    
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
