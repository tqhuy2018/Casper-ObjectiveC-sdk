#ifndef GetStateRootHash_h
#define GetStateRootHash_h
/**Class built for chain_get_state_root_hash RPC call
 */
#import <Foundation/Foundation.h>
@interface GetStateRootHash:NSObject

///This function get the state root hash from Json object taken from the POST request of chain_get_state_root_hash RPC call
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) fromDict;

/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
{"params" : [],"id" : 1,"method":"chain_get_state_root_hash","jsonrpc" : "2.0"}
 if you wish to send without any param along with the RPC call
 
or:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 if you wish to send the block hash along with the POST method in the RPC call
 
 or:
 
 {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Height" :100}},"jsonrpc" : "2.0"}
 if you wish to send the block height along with the POST method in the RPC call
 
 */
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString;
@end

#endif
