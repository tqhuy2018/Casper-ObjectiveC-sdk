#ifndef Bid_h
#define Bid_h
#import "U512Class.h"
#import "Delegator.h"
#import "VestingSchedule.h"
/**Class built for storing Bid information.
 */
@interface Bid:NSObject
@property NSString * bonding_purse;
@property uint delegation_rate;
@property bool inactive;
///list of Delegator
@property NSMutableArray * delegators;
@property U512Class * staked_amount;
@property NSString * validator_public_key;
///VestingSchedule value, which is optional
@property VestingSchedule * vesting_schedule;
///bool value to determine whether the vesting_schedule exists or not.
@property bool is_vesting_schedule_existed;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Bid object
 */
+(Bid*) fromJsonDictToBid:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
