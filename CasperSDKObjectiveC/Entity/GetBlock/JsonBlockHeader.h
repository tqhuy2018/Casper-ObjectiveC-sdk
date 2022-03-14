#import "JsonEraEnd.h"
#ifndef JsonBlockHeader_h
#define JsonBlockHeader_h

@interface JsonBlockHeader:NSObject
@property NSString * parent_hash;
@property NSString *  state_root_hash;
@property NSString * body_hash;
@property bool random_bit;
@property NSString * accumulated_seed;
@property JsonEraEnd * era_end;//optional
@property bool is_era_end_exists;
@property NSString * timestamp;
@property UInt64 era_id;
@property UInt64 height;
@property NSString * protocol_version;
+(JsonBlockHeader*) fromJsonDictToJsonBlockHeader:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
