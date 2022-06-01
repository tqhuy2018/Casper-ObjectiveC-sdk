#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonBlockBody.h>
/**Class built for storing JsonBlockBody information
 */
@implementation JsonBlockBody:NSObject
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlockBody object
 */
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

@end
