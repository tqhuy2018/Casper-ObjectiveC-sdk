#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_StoredContractByName.h>
@implementation ExecutableDeployItem_StoredContractByName
+(ExecutableDeployItem_StoredContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_StoredContractByName * ret = [[ExecutableDeployItem_StoredContractByName alloc] init];
    ret.name = fromDict[@"name"];
    ret.entry_point = fromDict[@"entry_point"];
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return  ret;
}
-(void) logInfo {
    NSLog(@"ExecutableDeployItem_StoredContractByName, name:%@",self.name);
    NSLog(@"ExecutableDeployItem_StoredContractByName, entry_point:%@",self.entry_point);
    [self.args logInfo];
}
@end
