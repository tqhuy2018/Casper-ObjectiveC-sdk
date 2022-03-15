#import <Foundation/Foundation.h>
#import "GetBlockResult.h"
@implementation GetBlockResult
+(GetBlockResult*) fromJsonDictToGetBlockResult:(NSDictionary *) jsonDict {
    GetBlockResult * ret = [[GetBlockResult alloc] init];
    ret.is_block_exists = true;
    NSDictionary * result = jsonDict[@"result"];
    ret.api_version = result[@"api_version"];
    ret.block = [JsonBlock fromJsonDictToJsonBlock:(NSDictionary*) result[@"block"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"GetBlockResult, api_version:%@",self.api_version);
    if (self.is_block_exists) {
        NSLog(@"GetBlockResult, block info:");
        [self.block logInfo];
    } else {
        NSLog(@"GetBlockResult, block does not exist");
    }
}
@end
