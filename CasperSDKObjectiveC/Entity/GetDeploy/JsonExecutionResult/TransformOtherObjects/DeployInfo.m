#import <Foundation/Foundation.h>
#import "DeployInfo.h"
@implementation DeployInfo
+(DeployInfo * ) fromJsonDictToDeployInfo:(NSDictionary*) fromDict {
    DeployInfo * ret = [[DeployInfo alloc] init];
    ret.deploy_hash = (NSString*) fromDict[@"deploy_hash"];
    ret.source = (NSString*) fromDict[@"source"];
    ret.from = (NSString*) fromDict[@"from"];
    ret.gas = [U512Class fromStrToClass:(NSString*) fromDict[@"gas"]];
    NSArray * listTransfer = fromDict[@"transfers"];
    int totalTransfer = (int) listTransfer.count;
    if (totalTransfer > 0) {
        ret.transfers = [[NSMutableArray alloc] init];
        ret.is_transfers_blank = false;
        for(int i = 0 ; i < totalTransfer ; i ++) {
            NSString * oneTransfer = (NSString*) [listTransfer objectAtIndex:i];
            [ret.transfers addObject: oneTransfer];
        }
    } else {
        ret.is_transfers_blank = true;
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"DeployInfo, deploy_hash:%@",self.deploy_hash);
    NSLog(@"DeployInfo, source:%@",self.source);
    NSLog(@"DeployInfo, from:%@",self.from);
    NSLog(@"DeployInfo, gas:%@",self.gas.itsValue);
    if(self.is_transfers_blank) {
        NSLog(@"Transfer list blank");
    } else {
        int totalTransfer = (int) self.transfers.count;
        NSLog(@"Total transfer:%i",totalTransfer);
        for(int i = 0 ; i < totalTransfer ; i ++) {
            NSLog(@"Transfer number %i value:%@",i,(NSString*)[self.transfers objectAtIndex:i]);
        }
    }
}
@end
