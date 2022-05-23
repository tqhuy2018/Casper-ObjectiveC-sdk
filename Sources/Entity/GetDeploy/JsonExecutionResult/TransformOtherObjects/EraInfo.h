#ifndef EraInfo_h
#define EraInfo_h
/**Class built for storing EraInfo information.
 */
@interface EraInfo:NSObject
///List of SeigniorageAllocation enum object
@property NSMutableArray * seigniorage_allocations;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to EraInfo object
 */
+(EraInfo*) fromJsonArrayToEraInfo:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
