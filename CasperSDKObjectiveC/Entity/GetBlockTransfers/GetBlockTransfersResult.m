#import <Foundation/Foundation.h>
#import "GetBlockTransfersResult.h"
#import "Transfer.h"
#import "ConstValues.h"
#import "HttpHandler.h"
@implementation GetBlockTransfersResult
+(GetBlockTransfersResult *) fromJsonDictToGetBlockTransfersResult:(NSDictionary*) jsonDict {
    GetBlockTransfersResult * ret = [[GetBlockTransfersResult alloc] init];
    ret.is_block_hash_exists = true;
    ret.is_transfers_exists = true;
    NSDictionary * result = jsonDict[@"result"];
    ret.api_version = result[@"api_version"];
    if(![result[@"block_hash"] isEqual:[NSNull null]]) {
        ret.block_hash = result[@"block_hash"];
    } else {
        ret.is_block_hash_exists = false;
    }
    if(![result[@"transfers"] isEqual:[NSNull null]]) {
        NSArray * listTransfer = result[@"transfers"];
        ret.transfers = [Transfer fromJsonDictToTransferList:listTransfer];
    } else {
        ret.is_block_hash_exists = false;
    }
    return ret;
}
+(void) getBlockTransfersWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_CHAIN_GET_BLOCK_TRANSFERS];
}
-(void) logInfo {
    NSLog(@"api_version:%@",self.api_version);
    if(self.is_block_hash_exists) {
        NSLog(@"block hash:%@",self.block_hash);
    }
    if (self.is_transfers_exists) {
        NSLog(@"total transfer:%lu",(unsigned long)self.transfers.count);
        if (self.transfers.count != 0) {
            for(int i = 0;i<self.transfers.count;i++) {
                Transfer * transferi = self.transfers[i];
                [transferi logInfo];
            }
        }
    }
}
@end
