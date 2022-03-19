#ifndef Transform_WriteBid_h
#define Transform_WriteBid_h
#import "U512Class.h"
#import "VestingSchedule.h"
@interface Transform_WriteBid:NSObject
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
+(Transform_WriteBid*) fromJsonDictToTransform_WriteBid:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
