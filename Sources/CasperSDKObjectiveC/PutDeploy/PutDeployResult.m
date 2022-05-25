#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/PutDeployResult.h>
@implementation PutDeployResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to PutDeployResult object
 */
+(PutDeployResult*) fromJsonObjectToPutDeployResult:(NSDictionary*) fromDict {
    PutDeployResult * ret = [[PutDeployResult alloc] init];
    ret.apiVersion = (NSString*) fromDict[@"api_version"];
    ret.deployHash = (NSString *) fromDict[@"deploy_hash"];
    return ret;
}
@end
