#import <Foundation/Foundation.h>
#import "GetBlockTransfersResult.h"
#import "Transfer.h"
@implementation GetBlockTransfersResult
+(GetBlockTransfersResult *) fromJsonDictToGetBlockTransfersResult:(NSDictionary*) jsonDict {
    GetBlockTransfersResult * ret = [[GetBlockTransfersResult alloc] init];
    ret.is_block_hash_exists = true;
    ret.is_transfers_exists = true;
    ret.api_version = jsonDict[@"api_version"];
    if(![jsonDict[@"block_hash"] isEqual:[NSNull null]]) {
        ret.block_hash = jsonDict[@"block_hash"];
    } else {
        ret.is_block_hash_exists = false;
    }
    if(![jsonDict[@"transfers"] isEqual:[NSNull null]]) {
        ret.transfers = [Transfer fromJsonDictToTransfer:jsonDict[@"transfers"]];
    } else {
        ret.is_block_hash_exists = false;
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"");
}
@end
