#import <Foundation/Foundation.h>
#import "ExecutableDeployItem_Transfer.h"
@implementation ExecutableDeployItem_Transfer
+(ExecutableDeployItem_Transfer*) fromJsonDictToObj:(NSDictionary*) fromDict {
    ExecutableDeployItem_Transfer * ret = [[ExecutableDeployItem_Transfer alloc] init];
    NSArray * listArgs = [[NSArray alloc] init];
    listArgs = (NSArray*) fromDict[@"args"];
    ret.args = [RuntimeArgs fromJsonArrayToRuntimeArg:listArgs];
    return ret;
}
-(void) logInfo {
    [self.args logInfo];
}
@end
