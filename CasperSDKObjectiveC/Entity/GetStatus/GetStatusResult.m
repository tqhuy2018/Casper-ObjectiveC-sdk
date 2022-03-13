#import <Foundation/Foundation.h>
#import "GetStatusResult.h"
#import "GetPeerList.h"
@implementation GetStatusResult
+(GetStatusResult *) fromJsonDictToGetStatusResult:(NSDictionary*) jsonDict {
    GetStatusResult * ret = [[GetStatusResult alloc] init];
    NSDictionary * result = jsonDict[@"result"];
    ret.api_version = result[@"api_version"];
    ret.chainspec_name = result[@"chainspec_name"];
    ret.peers = [GetPeerList fromJsonToPeerMap:result];
    ret.starting_state_root_hash = result[@"starting_state_root_hash"];
    ret.our_public_signing_key = result[@"our_public_signing_key"];
    ret.last_added_block_info = [[MinimalBlockInfo alloc]init];
    ret.last_added_block_info = [MinimalBlockInfo fromJsonToMinimalBlockInfo:result[@"last_added_block_info"]];
    return ret;
}
@end
