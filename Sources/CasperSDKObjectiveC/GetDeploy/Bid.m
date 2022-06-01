#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Bid.h>
/**Class built for storing Bid information.
 */
@implementation Bid
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Bid object
 */
+(Bid*) fromJsonDictToBid:(NSDictionary*) fromDict {
    Bid * ret = [[Bid alloc] init];
    ret.bonding_purse = fromDict[@"bonding_purse"];
    ret.inactive = [(NSString*) fromDict[@"inactive"] boolValue];
    ret.staked_amount = [U512Class fromStrToClass:(NSString*)fromDict[@"staked_amount"]];
    ret.delegation_rate = (int) [(NSString*) fromDict[@"delegation_rate"] intValue];
    ret.vesting_schedule = [VestingSchedule fromJsonDictToVestingSchedule:fromDict[@"vesting_schedule"]];
    ret.validator_public_key = (NSString*) fromDict[@"validator_public_key"];
    ret.delegators = [[NSMutableArray alloc] init];
    NSDictionary * delegatorDict = (NSDictionary *) fromDict[@"delegators"];
    for(NSString * key in delegatorDict ) {
        id value  = (NSDictionary*) delegatorDict[key];
        Delegator * oneDelegator = [[Delegator alloc] init];
        oneDelegator = [Delegator fromJsonDictToDelegator:(NSDictionary*) value];
        oneDelegator.itsPublicKey = key;
        [ret.delegators addObject:oneDelegator];
    }
    return  ret;
}
/*
-(void) logInfo {
    NSLog(@"Transform_WriteBid, bonding_purse:%@",self.bonding_purse);
    NSLog(@"Transform_WriteBid, inactive:%d",self.inactive);
    NSLog(@"Transform_WriteBid, staked_amount:%@",self.staked_amount.itsValue);
    NSLog(@"Transform_WriteBid, delegation_rate:%u",self.delegation_rate);
    NSLog(@"Transform_WriteBid, vesting_schedule");
    [self.vesting_schedule logInfo];
    NSLog(@"Transform_WriteBid, validator_public_key:%@",self.validator_public_key);
    NSLog(@"Total delegators:%i",(int) self.delegators.count);
    NSLog(@"Information of first delegator");
    Delegator * firstDelegator = (Delegator*) [self.delegators objectAtIndex:0];
    [firstDelegator logInfo];
}*/
@end
