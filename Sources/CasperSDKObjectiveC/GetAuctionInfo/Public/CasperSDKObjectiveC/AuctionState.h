#ifndef AuctionState_h
#define AuctionState_h
/**Class built for storing AuctionState information
 */
#import <Foundation/Foundation.h>
@interface AuctionState:NSObject
@property NSString*state_root_hash;
@property UInt64 block_height;
//List of JsonEraValidators;
@property NSMutableArray * era_validators;
+(AuctionState*) fromJsonDictToAuctionState:(NSDictionary*) fromDict;
@end

#endif
