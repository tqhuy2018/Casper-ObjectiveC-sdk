#import <Foundation/Foundation.h>
#import "GetEraInfoResult.h"
#import "ConstValues.h"
#import "HttpHandler.h"
@implementation GetEraInfoResult
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
