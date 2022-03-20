#import <Foundation/Foundation.h>
#import "Bid.h"


@implementation Bid
+(Bid*) fromJsonDictToBid:(NSDictionary*) fromDict {
    Bid * ret = [[Bid alloc] init];
    ret.bonding_purse = fromDict[@"bonding_purse"];
    ret.inactive = [(NSString*) fromDict[@"inactive"] boolValue];
    ret.staked_amount = [U512Class fromStrToClass:(NSString*)fromDict[@"staked_amount"]];
    ret.delegation_rate = (uint8) fromDict[@"delegation_rate"];
    ret.vesting_schedule = [VestingSchedule fromJsonDictToVestingSchedule:fromDict[@"vesting_schedule"]];
    ret.validator_public_key = (NSString*) fromDict[@"validator_public_key"];
    ret.delegators = [[NSMutableArray alloc] init];
    NSArray * listDelegator = (NSArray *) fromDict[@"delegators"];
    int totalDelegator = (int) listDelegator.count;
    NSLog(@"total delegator:%i",totalDelegator);
    for(int i = 0 ; i < totalDelegator ; i++ ) {
        NSDictionary * oneDelegatorDict = (NSDictionary*) [listDelegator objectAtIndex:i];
        NSLog(@"oneDelegatorDict:%@",oneDelegatorDict);
       // Delegator * oneDelegator = [Delegator fromJsonArrayToDelegator:oneDelegatorJsonArray];
       // [oneDelegator logInfo];
       // [ret.delegators addObject:oneDelegator];
    }
    return  ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteBid, bonding_purse:%@",self.bonding_purse);
    NSLog(@"Transform_WriteBid, inactive:%d",self.inactive);
    NSLog(@"Transform_WriteBid, staked_amount:%@",self.staked_amount.itsValue);
    NSLog(@"Transform_WriteBid, delegation_rate:%hhu",self.delegation_rate);
    NSLog(@"Transform_WriteBid, vesting_schedule");
    [self.vesting_schedule logInfo];
    NSLog(@"Transform_WriteBid, validator_public_key:%@",self.validator_public_key);
    NSLog(@"Total delegators:%i",(int) self.delegators.count);
    NSLog(@"Information of first delegator");
    Delegator * firstDelegator = (Delegator*) [self.delegators objectAtIndex:0];
    [firstDelegator logInfo];
}
@end
