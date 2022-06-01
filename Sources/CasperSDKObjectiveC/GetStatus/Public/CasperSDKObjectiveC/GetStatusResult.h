#ifndef GetStatusResult_h
#define GetStatusResult_h
#import "MinimalBlockInfo.h"
#import "NextUpgrade.h"
#import <Foundation/Foundation.h>
/**Class built for storing GetStatusResult information, taken from info_get_status RPC method
 */
@interface GetStatusResult : NSObject
@property NSString * api_version;
@property NSString * chainspec_name;
@property NSString * starting_state_root_hash;
@property NSMutableArray * peers;//PeerMap
@property MinimalBlockInfo* last_added_block_info;
@property NSString * our_public_signing_key;
@property NSString * round_length;
@property NextUpgrade * next_upgrade;
@property NSString * build_version;
@property NSString * uptime;
@property bool is_last_added_block_info_exists;
@property bool is_next_upgrade_exists;
@property bool is_our_public_signing_key_exists;
@property bool is_round_length_exists;

/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to GetStatusResult object
 */
+(GetStatusResult *) fromJsonDictToGetStatusResult:(NSDictionary*) jsonDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"params" : [],"id" : 1,"method":"info_get_status","jsonrpc" : "2.0"}
 
 */
+(void) getStatusWithParams:(NSString*) jsonString;
@end

#endif
