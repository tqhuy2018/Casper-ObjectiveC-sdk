#import <Foundation/Foundation.h>
#import "CasperSDKObjectiveC/BlockIdentifier.h"
/**
 This class is for storing information of POST parameter when call for RPC method such as chain_get_block or chain_get_state_root_hash or chain_get_block_transfers
 */
@implementation BlockIdentifier
    -(void) assignBlockHashWithParam:(NSString*) bHash{
        self.blockHash = bHash;
    }
    -(void) assignBlockHeigthtWithParam:(UInt64) bHeight {
        self.blockHeight = bHeight;
    }

/**This function build up the json parameter string, used for sending the POST method for RPC methods such as chain_get_block or chain_get_state_root_hash or chain_get_block_transfers
 
 * For example with RPC method "chain_get_state_root_hash" if USE_BLOCK_TYPE = USE_NONE the generated output will be like this
 
 {"params" : [],"id" : 1,"method":"chain_get_state_root_hash","jsonrpc" : "2.0"}
 
 * For example with RPC method "chain_get_block",  if USE_BLOCK_TYPE = USE_BLOCK_HASH and  BlockIdentifier object with blockHash = @"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e", the generated output will be like this:
 
 {"method" : "chain_get_block","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 
 * For example with RPC method "chain_get_state_root_hash",  if USE_BLOCK_TYPE = USE_BLOCK_HEIGHT and  BlockIdentifier object with blockHeight = 100, the generated output will be like this:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Height" :100}},"jsonrpc" : "2.0"}
 
 */
-(NSString*) toJsonStringWithMethodName:(NSString*) methodName {
    NSString * retJsonStr = @"";
    if(self.blockType == USE_BLOCK_HASH) {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" : {\"block_identifier\" : {\"Hash\" :\"%@\"}},\"jsonrpc\" : \"2.0\"}",methodName,self.blockHash];
    } else if (self.blockType == USE_BLOCK_HEIGHT) {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" : {\"block_identifier\" : {\"Height\" :%llu}},\"jsonrpc\" : \"2.0\"}",methodName,self.blockHeight];
    } else {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" :\"[]\",\"jsonrpc\" : \"2.0\"}",methodName];
    }
    return retJsonStr;
}
@end
