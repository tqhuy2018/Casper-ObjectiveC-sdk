#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetStatusParam.h>
@implementation GetStatusParam
-(NSString*) generateParamStr {
    return @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_status\",\"jsonrpc\" : \"2.0\"}";
}
@end
