#ifndef EraInfo_h
#define EraInfo_h
@interface EraInfo:NSObject
///List of SeigniorageAllocation enum object
@property NSMutableArray * seigniorage_allocations;
+(EraInfo*) fromJsonArrayToEraInfo:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
