#ifndef UnbondingPurse_h
#define UnbondingPurse_h
#import "U512Class.h"
/**Class built for storing UnbondingPurse information.
 */
@interface UnbondingPurse:NSObject
///bonding_purse of type URef, in String format
@property NSString * bonding_purse;
///validator_public_key of type PublicKey, in String format
@property NSString * validator_public_key;
///unbonder_public_key of type PublicKey, in String format
@property NSString * unbonder_public_key;
@property UInt64 era_of_creation;
@property U512Class * amount;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to UnbondingPurse object
 */
+(UnbondingPurse*) fromJsonDictToUnbondingPurse:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
