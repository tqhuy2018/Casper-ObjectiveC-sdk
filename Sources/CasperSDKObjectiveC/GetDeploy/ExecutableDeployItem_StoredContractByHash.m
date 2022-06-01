#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByHash.h>
@implementation ExecutableDeployItem_StoredContractByHash
+(ExecutableDeployItem_StoredContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_StoredContractByHash * ret = [[ExecutableDeployItem_StoredContractByHash alloc] init];
    ret.itsHash = fromDict[@"hash"];
    ret.entry_point = fromDict[@"entry_point"];
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return  ret;
}
-(void) logInfo {
    NSLog(@"ExecutableDeployItem_StoredContractByHash, hash:%@",self.itsHash);
    NSLog(@"ExecutableDeployItem_StoredContractByHash, entry_point:%@",self.entry_point);
    //[self.args logInfo];
}
@end
