#ifndef MinimalBlockInfo_h
#define MinimalBlockInfo_h
@interface MinimalBlockInfo : NSObject

@property NSString * creator;
@property UInt64 era_id;
@property NSString * itsHash;
@property UInt64 height;
@property NSString * state_root_hash;
@property NSString * timestamp;
+(MinimalBlockInfo*) fromJsonToMinimalBlockInfo : (NSDictionary *) fromDict;
@end

#endif 
