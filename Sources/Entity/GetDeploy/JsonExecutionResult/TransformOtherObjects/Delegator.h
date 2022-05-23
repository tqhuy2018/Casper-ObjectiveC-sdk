#ifndef Delegator_h
#define Delegator_h
#import "U512Class.h"
#import "VestingSchedule.h"
/**Class built for storing Delegator information. Delegator class is used for  getting information for Transform<Bid> in get_deploy => JsonExecutionResult
 */
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
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Delegator object
 */
+(Delegator*) fromJsonDictToDelegator:(NSDictionary *) fromDict;
-(void) logInfo;
@end

#endif
