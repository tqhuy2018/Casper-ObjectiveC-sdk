#ifndef UnbondingPurse_h
#define UnbondingPurse_h
#import "U512Class.h"
@interface UnbondingPurse:NSObject
///bonding_purse of type URef, in String format
@property NSString * bonding_purse;
///validator_public_key of type PublicKey, in String format
@property NSString * validator_public_key;
///unbonder_public_key of type PublicKey, in String format
@property NSString * unbonder_public_key;
@property UInt64 era_of_creation;
@property U512Class * amount;
+(UnbondingPurse*) fromJsonDictToUnbondingPurse:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
