#import <Foundation/Foundation.h>
#import "Deploy.h"
#import "DeployHeader.h"
/**Class built for storing Deploy information
 */
@implementation Deploy
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Deploy object
 */
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
