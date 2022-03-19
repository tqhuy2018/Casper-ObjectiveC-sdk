#ifndef VestingSchedule_h
#define VestingSchedule_h
@interface VestingSchedule:NSObject
@property UInt64 initial_release_timestamp_millis;
///List of locked_amounts, which is a fixed array of 14 U512 items.
@property NSMutableArray * locked_amounts;
+(VestingSchedule*) fromJsonDictToVestingSchedule:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
