#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/VestingSchedule.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing VestingSchedule information.
 */
@implementation VestingSchedule
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to VestingSchedule object
 */
+(VestingSchedule*) fromJsonDictToVestingSchedule:(NSDictionary*) fromDict {
    VestingSchedule * ret = [[VestingSchedule alloc]init];
    ret.initial_release_timestamp_millis = [(NSString*) fromDict[@"initial_release_timestamp_millis"] longLongValue];
    NSArray * listLockAmount = (NSArray*) fromDict[@"locked_amounts"];
    ret.locked_amounts = [[NSMutableArray alloc] init];
    int totalLA  = (int) listLockAmount.count;
    for(int i = 0 ;i < totalLA; i ++ ) {
        NSString * itemStr = (NSString*)[listLockAmount objectAtIndex:i];
        U512Class * itemU512 = [U512Class fromStrToClass:itemStr];
        [ret.locked_amounts addObject:itemU512];
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"VestingSchedule, initial_release_timestamp_millis:%llu",self.initial_release_timestamp_millis);
    int totalLockAmount = (int)self.locked_amounts.count;//14
    for (int i = 0 ; i < totalLockAmount ; i ++) {
        U512Class * item = (U512Class*) [self.locked_amounts objectAtIndex:i];
        NSLog(@"VestingSchedule, lock_amount item number %i value %@",i,item.itsValue);
    }
}
@end
