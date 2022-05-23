#import <Foundation/Foundation.h>
#import "UnbondingPurse.h"
#import "U512Class.h"
/**Class built for storing UnbondingPurse information.
 */
@implementation UnbondingPurse
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to UnbondingPurse object
 */
+(UnbondingPurse*) fromJsonDictToUnbondingPurse:(NSDictionary*) fromDict{
    UnbondingPurse * ret = [[UnbondingPurse alloc] init];
    ret.bonding_purse = fromDict[@"bonding_purse"];
    ret.validator_public_key = fromDict[@"validator_public_key"];
    ret.unbonder_public_key = fromDict[@"unbonder_public_key"];
    ret.era_of_creation = [(NSString*) fromDict[@"era_of_creation"] longLongValue];
    ret.amount = [U512Class fromStrToClass:(NSString*) fromDict[@"amount"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"UnbondingPurse, bounding_purse:%@",self.bonding_purse);
    NSLog(@"UnbondingPurse, validator_public_key:%@",self.validator_public_key);
    NSLog(@"UnbondingPurse, unbonder_public_key:%@",self.unbonder_public_key);
    NSLog(@"UnbondingPurse, era_of_creation:%llu",self.era_of_creation);
    NSLog(@"UnbondingPurse, amount:%@",self.amount.itsValue);
}
@end
