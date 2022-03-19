#import <Foundation/Foundation.h>
#import "Delegator.h"
@implementation Delegator
+(Delegator*) fromJsonArrayToDelegator:(NSArray *) fromArray {
    Delegator * ret = [[Delegator alloc] init];
    ret.itsPublicKey = (NSString*) [fromArray objectAtIndex:0];
    NSDictionary* dDict = (NSDictionary*) [fromArray objectAtIndex:1];
    ret.bonding_purse = (NSString*) dDict[@"bonding_purse"];
    ret.staked_amount = [U512Class fromStrToClass:(NSString*)dDict[@"staked_amount"]];
    if(!(dDict[@""] == nil)) {
        ret.vesting_schedule = [VestingSchedule fromJsonDictToVestingSchedule:dDict[@"vesting_schedule"]];
        ret.is_vesting_schedule_existed = true;
    } else {
        ret.is_vesting_schedule_existed = false;
    }
    ret.delegator_public_key = dDict[@"delegator_public_key"];
    ret.validator_public_key = dDict[@"validator_public_key"];
    return ret;
}
-(void) logInfo {
    NSLog(@"Delegator, itsPublicKey:%@",self.itsPublicKey);
    NSLog(@"Delegator, bonding_purse:%@",self.bonding_purse);
    NSLog(@"Delegator, delegator_public_key:%@",self.delegator_public_key);
    NSLog(@"Delegator, validator_public_key:%@",self.validator_public_key);
    NSLog(@"Delegator, staked_amount:%@",self.staked_amount.itsValue);
    if(self.is_vesting_schedule_existed) {
        NSLog(@"Delegator, vesting schedule");
        [self.vesting_schedule logInfo];
    } else {
        NSLog(@"Vesting schedule: NULL");
    }

}
@end
