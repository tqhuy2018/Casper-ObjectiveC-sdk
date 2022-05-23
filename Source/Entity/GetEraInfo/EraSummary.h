#ifndef EraSummary_h
#define EraSummary_h
#import "StoredValue.h"
/**Class built for storing EraSummary information
 */
@interface EraSummary:NSObject
@property NSString* block_hash;
@property UInt64 era_id;
@property NSString * state_root_hash;
@property NSString * merkle_proof;
@property StoredValue * stored_value;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to EraSummary object
 */
+(EraSummary*) fromJsonDictToEraSummary:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
