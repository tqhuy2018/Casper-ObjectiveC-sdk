#import <Foundation/Foundation.h>
#import "GetDeployParams.h"
@implementation GetDeployParams
-(NSString *) generatePostParam {
    return [[NSString alloc] initWithFormat: @"{\"id\" : 1,\"method\" : \"info_get_deploy\",\"params\" : {\"deploy_hash\" : \"%@\"},\"jsonrpc\" : \"2.0\"}",self.deploy_hash];
}
@end
