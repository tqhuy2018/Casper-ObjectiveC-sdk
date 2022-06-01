#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetBlockTransfersResult.h>
#import <CasperSDKObjectiveC/Transfer.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for storing GetBlockTransfersResult information
 */
@implementation GetBlockTransfersResult
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetBlockTransfersResult object
 */
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
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "chain_get_block_transfers","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 */
+(void) getBlockTransfersWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_CHAIN_GET_BLOCK_TRANSFERS];
}
@end
