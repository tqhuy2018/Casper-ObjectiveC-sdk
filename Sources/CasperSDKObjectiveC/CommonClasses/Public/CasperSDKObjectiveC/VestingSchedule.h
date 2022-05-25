#ifndef VestingSchedule_h
#define VestingSchedule_h
#import <Foundation/Foundation.h>
/**Class built for storing VestingSchedule information.
 */
@interface VestingSchedule:NSObject
@property UInt64 initial_release_timestamp_millis;
///List of locked_amounts, which is a fixed array of 14 U512 items.
@property NSMutableArray * locked_amounts;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to VestingSchedule object
 */
+(VestingSchedule*) fromJsonDictToVestingSchedule:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
