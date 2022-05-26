#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetPeerParam.h>
@implementation GetPeerParam
-(NSString*) generateParamStr {
    return @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_peers\",\"jsonrpc\" : \"2.0\"}";
}
@end
