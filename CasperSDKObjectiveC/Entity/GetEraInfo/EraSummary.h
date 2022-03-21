#ifndef EraSummary_h
#define EraSummary_h
#import "StoredValue.h"
@interface EraSummary:NSObject
@property NSString* block_hash;
@property UInt64 era_id;
@property NSString * state_root_hash;
@property NSString * merkle_proof;
@property StoredValue * stored_value;
+(EraSummary*) fromJsonDictToEraSummary:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
