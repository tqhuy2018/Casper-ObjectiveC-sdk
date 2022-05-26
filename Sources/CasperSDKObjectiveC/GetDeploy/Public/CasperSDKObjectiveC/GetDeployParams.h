#ifndef GetDeployParams_h
#define GetDeployParams_h
#import <Foundation/Foundation.h>
/**Class built for storing GetDeployParams information, used for sending info_get_deploy RPC method
 */
@interface GetDeployParams:NSObject
@property NSString * deploy_hash;
/**This function generate the json data used for sending POST method for info_get_deploy RPC call.
Based on the deploy_hash, the JSON string is built somehow like this:
 
 {"id" : 1,"method" : "info_get_deploy","params" : {"deploy_hash" : "6e74f836d7b10dd5db7430497e106ddf56e30afee993dd29b85a91c1cd903583"},"jsonrpc" : "2.0"}
 
 */
-(NSString *) generatePostParam;
@end

#endif
