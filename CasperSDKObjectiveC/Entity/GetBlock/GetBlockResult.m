#import <Foundation/Foundation.h>
#import "GetBlockResult.h"
#import "ConstValues.h"
#import "HttpHandler.h"
@implementation GetBlockResult
+(GetBlockResult*) fromJsonDictToGetBlockResult:(NSDictionary *) jsonDict {
    GetBlockResult * ret = [[GetBlockResult alloc] init];
    ret.is_block_exists = true;
    ret.api_version = jsonDict[@"api_version"];
    ret.block = [JsonBlock fromJsonDictToJsonBlock:(NSDictionary*) jsonDict[@"block"]];
    return ret;
}
+(void) getBlockWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_CHAIN_GET_BLOCK];
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
