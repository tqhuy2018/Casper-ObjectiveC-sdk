#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ExecutableDeployItem_ModuleBytes.h>
@implementation ExecutableDeployItem_ModuleBytes
+(ExecutableDeployItem_ModuleBytes*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_ModuleBytes * ret = [[ExecutableDeployItem_ModuleBytes alloc] init];
    if(![fromDict[@"module_bytes"] isEqual:[NSNull null]]) {
        ret.module_bytes = fromDict[@"module_bytes"];
    } else {
        ret.module_bytes = @"";
    }
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return ret;
}

@end
