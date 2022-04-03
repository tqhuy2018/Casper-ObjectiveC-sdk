#ifndef Utils_h
#define Utils_h
@interface Utils:NSObject
///This function change timestamp in format of "2020-11-17T00:39:24.072Z" to millisecondsSince1970 U64 number in String format like this "1605573564072"
+(uint64_t) fromTimeStampToU64Str:(NSString*) timeStamp;
///This function change time to live (ttl) in format of "1d" or "2h" or "3m" to U64 number in String format
///value of time to live (ttl) based on this site https://docs.rs/humantime/latest/humantime/fn.parse_duration.html
+(uint64_t) fromTimeToLiveToU64Str:(NSString*) ttl;
@end

#endif
