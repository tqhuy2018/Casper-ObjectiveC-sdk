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
    NSArray * listTransferHashes = fromDict[@"deploy_hashes"];
    for (id obj in listTransferHashes) {
        [ret.transfer_hashes addObject: (NSString*) obj];
    }
    return ret;
}

@end
