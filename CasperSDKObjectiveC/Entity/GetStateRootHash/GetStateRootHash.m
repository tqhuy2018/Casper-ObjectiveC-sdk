#import <Foundation/Foundation.h>
#import "GetStateRootHash.h"
#import "HttpHandler.h"
#import "ConstValues.h"
@implementation GetStateRootHash

///This function get the state root hash from Json object taken from the POST request of chain_get_state_root_hash RPC call
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) fromDict {
    NSDictionary * result = [fromDict objectForKey:@"result"];
    NSString * state_root_hash = [result objectForKey:@"state_root_hash"];
    return state_root_hash;
}

///This function initiate the process of sending POST request with given parameter in JSON string format
///The input jsonString is used to send to server as parameter of the POST request to get the result back
///The input jsonString is somehow like this: {"params" : [],"id" : 1,"method":"chain_get_state_root_hash","jsonrpc" : "2.0"} if you wish to send without any param along with the RPC call
///or {"method" : "chain_get_state_root_hash","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"} if you wish to send the block hash along with the POST method in the RPC call
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
}

@end
