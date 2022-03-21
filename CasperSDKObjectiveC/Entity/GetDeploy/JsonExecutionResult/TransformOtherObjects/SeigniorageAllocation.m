#import <Foundation/Foundation.h>
#import "SeigniorageAllocation.h"
@implementation SeigniorageAllocation
+(SeigniorageAllocation*) fromJsonDictToSeigniorageAllocation:(NSDictionary*) fromDict {
    SeigniorageAllocation * ret = [[SeigniorageAllocation alloc] init];
    if(!(fromDict[@"Validator"] == nil)) { //of type Validator
        NSDictionary * vDict = (NSDictionary*) fromDict[@"Validator"];
        ret.validator_public_key = vDict[@"validator_public_key"];
        ret.amount = [U512Class fromStrToClass:(NSString*)vDict[@"amount"]];
        ret.isDelegatorEnum = false;
    } else {  //of type Delegator
        NSDictionary * vDict = (NSDictionary*) fromDict[@"Delegator"];
        ret.validator_public_key = vDict[@"validator_public_key"];
        ret.delegator_public_key = vDict[@"delegator_public_key"];
        ret.amount = [U512Class fromStrToClass:(NSString*)vDict[@"amount"]];
        ret.isDelegatorEnum = true;
    }
    return ret;
}
-(void) logInfo {
    if(self.isDelegatorEnum) {
        NSLog(@"-----SeigniorageAllocation of type Delegator");
        NSLog(@"SeigniorageAllocation Delegator, validator_public_key:%@",self.validator_public_key);
        NSLog(@"SeigniorageAllocation Delegator, delegator_public_key:%@",self.delegator_public_key);
        NSLog(@"SeigniorageAllocation Delegator, amount:%@",self.amount.itsValue);
    } else {
        NSLog(@"-----SeigniorageAllocation of type Validator");
        NSLog(@"SeigniorageAllocation Validator, validator_public_key:%@",self.validator_public_key);
        NSLog(@"SeigniorageAllocation Validator, amount:%@",self.amount.itsValue);
    }
}
@end
