#import <Foundation/Foundation.h>
#import "JsonBlockBody.h"

@implementation JsonBlockBody:NSObject
+(JsonBlockBody*) fromJsonDictToJsonBlockBody:(NSDictionary *) fromDict {
    
    JsonBlockBody * ret = [[JsonBlockBody alloc] init];
    ret.proposer = fromDict[@"proposer"];
    ret.deploy_hashes = [[NSMutableArray alloc]init];
    ret.transfer_hashes = [[NSMutableArray alloc] init];
    NSArray * listDeployHash = fromDict[@"deploy_hashes"];
    for (id obj in listDeployHash) {
        [ret.deploy_hashes addObject: (NSString*) obj];
    }
    NSArray * listTransferHashes = fromDict[@"transfer_hashes"];
    for (id obj in listTransferHashes) {
        [ret.transfer_hashes addObject: (NSString*) obj];
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonBlockBody, proposer:%@",self.proposer);
    NSLog(@"JsonBlockBody, total deploy_hashes:%lu",self.deploy_hashes.count);
    NSLog(@"JsonBlockBody, total transfer_hashes:%lu",self.transfer_hashes.count);
    if(self.deploy_hashes.count > 0) {
        NSLog(@"JsonBlockBody, first deploy hash:%@",self.deploy_hashes.firstObject);
    }
    if(self.transfer_hashes.count>0) {
        NSLog(@"JsonBlockBody, first transfer hash:%@",self.transfer_hashes.firstObject);//not done
    }
}
@end
