#ifndef GetStatusResult_h
#define GetStatusResult_h
#import "MinimalBlockInfo.h"
#import "NextUpgrade.h"
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
+(GetStatusResult *) fromJsonDictToGetStatusResult:(NSDictionary*) jsonDict;
@end

#endif
