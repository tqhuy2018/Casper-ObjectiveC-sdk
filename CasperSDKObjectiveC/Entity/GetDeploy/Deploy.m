#import <Foundation/Foundation.h>
#import "Deploy.h"
#import "DeployHeader.h"
@implementation Deploy
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict {
    Deploy * ret = [[Deploy alloc] init];
    ret.itsHash = fromDict[@"hash"];
    ret.header = [DeployHeader fromJsonDictToDeployHeader:fromDict[@"header"]];
    ret.payment = [ExecutableDeployItem fromJsonDictToExecutableDeployItem:fromDict[@"payment"]];
    ret.session = [ExecutableDeployItem fromJsonDictToExecutableDeployItem:fromDict[@"session"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"Deploy, hash:%@",self.itsHash);
    NSLog(@"Deploy header log:");
    [self.header logInfo];
    NSLog(@"Deploy payment log:");
    [self.payment logInfo];
    NSLog(@"Deploy session log:");
    [self.session logInfo];
}
@end
