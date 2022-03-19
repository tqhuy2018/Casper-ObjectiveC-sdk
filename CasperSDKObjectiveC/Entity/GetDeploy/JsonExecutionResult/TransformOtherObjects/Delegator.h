#ifndef Delegator_h
#define Delegator_h
#import "U512Class.h"
#import "VestingSchedule.h"
///Delegator class, used for  getting information for Transform<Bid> in get_deploy => JsonExecutionResult
@interface Delegator:NSObject
@property NSString * itsPublicKey;
@property NSString * bonding_purse;
@property U512Class * staked_amount;
@property NSString * validator_public_key;
@property NSString * delegator_public_key;
///VestingSchedule value, which is optional
@property VestingSchedule * vesting_schedule;
///bool property to check whethere the VestingSchedule exists
@property bool is_vesting_schedule_existed;
+(Delegator*) fromJsonArrayToDelegator:(NSArray *) fromArray;
-(void) logInfo;
@end

#endif
