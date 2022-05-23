#import "Transfer.h"
#ifndef GetBlockTransfersResult_h
#define GetBlockTransfersResult_h
/**Class built for storing GetBlockTransfersResult information
 */
@interface GetBlockTransfersResult : NSObject
@property NSString * api_version;
@property NSString * block_hash;//optional
@property NSMutableArray * transfers;//optional
@property bool is_transfers_exists;
@property bool is_block_hash_exists;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetBlockTransfersResult object
 */
+(GetBlockTransfersResult *) fromJsonDictToGetBlockTransfersResult:(NSDictionary*) jsonDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "chain_get_block_transfers","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 
 */
+(void) getBlockTransfersWithParams:(NSString*) jsonString;
-(void) logInfo;
@end

#endif 
