#import <Foundation/Foundation.h>
#import "GetEraInfoResult.h"
#import "ConstValues.h"
#import "HttpHandler.h"
/**Class built for storing GetEraInfoResult information, taken from chain_get_era_info_by_switch_block RPC method
 */
@implementation GetEraInfoResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetEraInfoResult object
 */
+(GetEraInfoResult*) fromJsonDictToGetEraInfoResult:(NSDictionary*) fromDict {
    GetEraInfoResult * ret = [[GetEraInfoResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    if(!(fromDict[@"era_summary"] == nil)) {
        NSObject * obj = fromDict[@"era_summary"];
        if([obj isKindOfClass:[NSString class]]) {
            NSString * vs = (NSString *) fromDict[@"era_summary"];
            if(vs==(id) [NSNull null] || [vs length]==0 || [vs isEqualToString:@""]) {
                ret.is_era_summary_existed = false;
            }
        } else {
            if(obj==(id) [NSNull null]) {
                ret.is_era_summary_existed = false;
            } else {
                ret.is_era_summary_existed = true;
                ret.era_summary = [EraSummary fromJsonDictToEraSummary:fromDict[@"era_summary"]];
            }
        }
    }
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "chain_get_era_info_by_switch_block","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 */
+(void) getEraInfoWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_CHAIN_GET_ERA_BY_SWITCH_BLOCK];
}
-(void)logInfo {
    NSLog(@"GetEraInfoResult, api_version:%@",self.api_version);
    if(self.is_era_summary_existed) {
        [self.era_summary logInfo];
    } else {
        NSLog(@"GetEraInfoResult, era_summary does not exists");
    }
}
@end
