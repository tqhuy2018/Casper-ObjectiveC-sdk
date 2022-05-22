#import <Foundation/Foundation.h>
#import "Utils.h"
@implementation Utils
///This function change timestamp in format of "2020-11-17T00:39:24.072Z" to millisecondsSince1970 U64 number in String format like this "1605573564072"
+(UInt64 ) fromTimeStampToU64Str:(NSString*) timeStamp {
    //Get the miliseconds
    NSArray * elements = [timeStamp componentsSeparatedByString:@"."];
    NSString * miliSecondsZ = (NSString*) elements[1];
    NSString * miliSeconds = [miliSecondsZ substringToIndex:3];
    int ms = (int) [miliSeconds integerValue];
    NSString * realTime = [NSString stringWithFormat:@"%@Z",(NSString*) elements[0]];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate * date = [dateFormatter dateFromString:realTime];
    double ms2 = [date timeIntervalSince1970];
    double totalSeconds = ms2 * 1000 + ms;
    UInt64 ret64 = (UInt64) totalSeconds;
   // ret = [NSString stringWithFormat:@"%llu",ret64];
    return ret64;
}
///This function change time to live (ttl) in format of "1d" or "2h" or "3m" to U64 number in String format
///value of time to live (ttl) based on this site https://docs.rs/humantime/latest/humantime/fn.parse_duration.html
+(UInt64) fromTimeToLiveToU64Str:(NSString*) ttl {
    //check for ttl in format of "3d 2h" or "1d 2h 6m"
    if ([ttl containsString:@" "]) {
        NSArray * elements = [ttl componentsSeparatedByString:@" "];
        int totalElements = (int)[elements count];
        UInt64 valueBack = 0;
        for(int i = 0 ; i < totalElements; i ++ ) {
            valueBack = valueBack + [Utils fromTimeToLiveToU64Str:(NSString *)[elements objectAtIndex:i]];
        }
        return valueBack;
    }
    if([ttl containsString:@"days"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfDayStr = [ttl substringToIndex:(ttlLength-4)];
        int numOfDays = (int) [numberOfDayStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfDays * 24 * 3600 * 1000);
        return valueBack;
    }
    if([ttl containsString:@"day"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfDayStr = [ttl substringToIndex:(ttlLength-3)];
        int numOfDays = (int) [numberOfDayStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfDays * 24 * 3600 * 1000);
        return valueBack;
    }
   
    if([ttl containsString:@"months"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfMonthStr = [ttl substringToIndex:(ttlLength-6)];
        int numOfMonths = (int) [numberOfMonthStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMonths * 3600 * 1000 * 24 * 30 + numOfMonths * 3600 * 440 * 24);
        return valueBack;
    }
    if([ttl containsString:@"month"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfMonthStr = [ttl substringToIndex:(ttlLength-5)];
        int numOfMonths = (int) [numberOfMonthStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMonths * 3600 * 1000 * 24 * 30 + numOfMonths * 3600 * 440 * 24);
        return valueBack;
    }
    if([ttl containsString:@"M"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfMonthStr = [ttl substringToIndex:(ttlLength-1)];
        int numOfMonths = (int) [numberOfMonthStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMonths * 3600 * 1000 * 24 * 30 + numOfMonths * 3600 * 440 * 24);
        return valueBack;
    }
    if([ttl containsString:@"minutes"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfMinutesStr = [ttl substringToIndex:(ttlLength-7)];
        int numOfMinutes = (int) [numOfMinutesStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMinutes * 60 * 1000);
        return valueBack;
    }
    if([ttl containsString:@"minute"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfMinutesStr = [ttl substringToIndex:(ttlLength-6)];
        int numOfMinutes = (int) [numOfMinutesStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMinutes * 60 * 1000);
        return valueBack;
    }
    if([ttl containsString:@"min"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfMinutesStr = [ttl substringToIndex:(ttlLength-3)];
        int numOfMinutes = (int) [numOfMinutesStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMinutes * 60 * 1000);
        return valueBack;
    }
  
    if([ttl containsString:@"hours"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfHourStr = [ttl substringToIndex:(ttlLength-5)];
        int numOfHour = (int) [numOfHourStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfHour * 3600 * 1000);
        return valueBack;
    }
    if([ttl containsString:@"hour"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfHourStr = [ttl substringToIndex:(ttlLength-4)];
        int numOfHour = (int) [numOfHourStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfHour * 3600 * 1000);
        return valueBack;
    }
    if([ttl containsString:@"hr"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfHourStr = [ttl substringToIndex:(ttlLength-2)];
        int numOfHour = (int) [numOfHourStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfHour * 3600 * 1000);
        return valueBack;
    }
    
    if([ttl containsString:@"weeks"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-5)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 7);
        return valueBack;
    }
    if([ttl containsString:@"week"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-4)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 7);
        return valueBack;
    }
    if([ttl containsString:@"w"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-1)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 7);
        return valueBack;
    }
    if([ttl containsString:@"years"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-5)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 365 + num * 3600 * 250 * 24);
        return valueBack;
    }
    if([ttl containsString:@"year"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-4)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 365 + num * 3600 * 250 * 24);
        return valueBack;
    }
    if([ttl containsString:@"y"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-1)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 3600 * 1000 * 24 * 365 + num * 3600 * 250 * 24);
        return valueBack;
    }
    if([ttl containsString:@"msec"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-4)];
        uint64_t valueBack = (uint64_t) [numStr integerValue];
        return valueBack;
    }
    if([ttl containsString:@"ms"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-2)];
        uint64_t valueBack = (uint64_t) [numStr integerValue];
        return valueBack;
    }
    
    if([ttl containsString:@"seconds"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-7)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 1000);
        return valueBack;
    }
    if([ttl containsString:@"second"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-6)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 1000);
        return valueBack;
    }
    if([ttl containsString:@"sec"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-3)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 1000);
        return valueBack;
    }
    //day
    if([ttl containsString:@"d"]) {
        int ttlLength = (int) [ttl length];
        NSString * numberOfDayStr = [ttl substringToIndex:(ttlLength-1)];
        int numOfDays = (int) [numberOfDayStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfDays * 24 * 3600 * 1000);
        return valueBack;
    }
    //hour
    if([ttl containsString:@"h"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfHourStr = [ttl substringToIndex:(ttlLength-1)];
        int numOfHour = (int) [numOfHourStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfHour * 3600 * 1000);
        return valueBack;
    }
    //second
    if([ttl containsString:@"s"]) {
        int ttlLength = (int) [ttl length];
        NSString * numStr = [ttl substringToIndex:(ttlLength-1)];
        int num = (int) [numStr integerValue];
        uint64_t valueBack = (uint64_t) (num * 1000);
        return valueBack;
    }
    //minute
    if([ttl containsString:@"m"]) {
        int ttlLength = (int) [ttl length];
        NSString * numOfMinutesStr = [ttl substringToIndex:(ttlLength-1)];
        int numOfMinutes = (int) [numOfMinutesStr integerValue];
        uint64_t valueBack = (uint64_t) (numOfMinutes * 60 * 1000);
        return valueBack;
    }
    return 0;
}

@end
