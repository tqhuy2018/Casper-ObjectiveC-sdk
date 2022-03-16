#import <Foundation/Foundation.h>
#import "Deploy.h"
#import "DeployHeader.h"
@implementation Deploy
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict {
    Deploy * ret = [[Deploy alloc] init];
    ret.itsHash = fromDict[@"hash"];
    ret.header = [DeployHeader fromJsonDictToDeployHeader:fromDict[@"header"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"Deploy, hash:%@",self.itsHash);
    [self.header logInfo];
}
@end
