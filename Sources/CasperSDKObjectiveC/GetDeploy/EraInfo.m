#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/EraInfo.h>
#import <CasperSDKObjectiveC/SeigniorageAllocation.h>
/**Class built for storing EraInfo information.
 */
@implementation EraInfo
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to EraInfo object
 */
+(EraInfo*) fromJsonArrayToEraInfo:(NSArray*) fromArray {
    EraInfo * ret = [[EraInfo alloc] init];
    int totalElement = (int) fromArray.count;
    if(totalElement>0) {
        ret.seigniorage_allocations = [[NSMutableArray alloc] init];
        for(int i = 0; i < totalElement ; i ++) {
            //Get one  SeigniorageAllocation, then add to the list of SeigniorageAllocation
            SeigniorageAllocation * oneItem = [[SeigniorageAllocation alloc] init];
            oneItem = [SeigniorageAllocation fromJsonDictToSeigniorageAllocation:[fromArray objectAtIndex:i]];
            [ret.seigniorage_allocations addObject:oneItem];
        }
    }
    return ret;
}
@end
