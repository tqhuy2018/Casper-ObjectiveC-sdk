#ifndef AuctionState_h
#define AuctionState_h
/**Class built for storing AuctionState information
 */
@interface AuctionState:NSObject
@property NSString*state_root_hash;
@property UInt64 block_height;
//List of JsonEraValidators;
@property NSMutableArray * era_validators;
+(AuctionState*) fromJsonDictToAuctionState:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
