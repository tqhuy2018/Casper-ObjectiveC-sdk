#ifndef Bid_h
#define Bid_h
#import "U512Class.h"
#import "Delegator.h"
#import "VestingSchedule.h"
@interface Bid:NSObject
@property NSString * bonding_purse;
@property uint8 delegation_rate;
@property bool inactive;
///list of Delegator
@property NSMutableArray * delegators;
@property U512Class * staked_amount;
@property NSString * validator_public_key;
///VestingSchedule value, which is optional
@property VestingSchedule * vesting_schedule;
///bool value to determine whether the vesting_schedule exists or not.
@property bool is_vesting_schedule_existed;
+(Bid*) fromJsonDictToBid:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif