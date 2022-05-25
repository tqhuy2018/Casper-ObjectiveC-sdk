#import <Foundation/Foundation.h>

#ifndef BlockIdentifier_h
#define BlockIdentifier_h
///An enum type to determined whether the BlockIdentifier use its inner value: hash, height or none
///Used to send the parameter to RPC method, such as chain_get_state_root_hash or chain_get_block or chain_get_block_transfers
typedef NS_ENUM(NSInteger,USE_BLOCK_TYPE) {
    USE_BLOCK_HEIGHT = 1,
    USE_BLOCK_HASH = 2,
    USE_NONE = 3
};
/**
 This class is for storing information of POST parameter when call for RPC method such as chain_get_block or chain_get_state_root_hash or chain_get_block_transfers
 */
@interface BlockIdentifier:NSObject
@property NSString * blockHash;
@property UInt64 blockHeight;
@property USE_BLOCK_TYPE blockType;
-(void) assignBlockHashWithParam:(NSString*) bHash;
-(void) assignBlockHeigthtWithParam:(UInt64) bHeight;

/**This function build up the json parameter string, used for sending the POST method for RPC methods such as chain_get_block or chain_get_state_root_hash or chain_get_block_transfers
 
 * For example with RPC method "chain_get_state_root_hash" if USE_BLOCK_TYPE = USE_NONE the generated output will be like this
 
 {"params" : [],"id" : 1,"method":"chain_get_state_root_hash","jsonrpc" : "2.0"}
 
 * For example with RPC method "chain_get_block",  if USE_BLOCK_TYPE = USE_BLOCK_HASH and  BlockIdentifier object with blockHash = @"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e", the generated output will be like this:
 
 {"method" : "chain_get_block","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 
 * For example with RPC method "chain_get_state_root_hash",  if USE_BLOCK_TYPE = USE_BLOCK_HEIGHT and  BlockIdentifier object with blockHeight = 100, the generated output will be like this:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Height" :100}},"jsonrpc" : "2.0"}
 
 */
-(NSString*) toJsonStringWithMethodName:(NSString*) methodName;
@end

#endif
