#import <Foundation/Foundation.h>
#import "EraInfo.h"
#import "SeigniorageAllocation.h"
@implementation EraInfo
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
-(void) logInfo {
    int totalSeigniorageAllocation = (int) self.seigniorage_allocations.count;
    NSLog(@"EraInfo, total SeigniorageAllocation:%i",totalSeigniorageAllocation);
    if (totalSeigniorageAllocation>0) {
        NSLog(@"EraInfo, information for first SeigniorageAllocation item");
        SeigniorageAllocation * oneItem = (SeigniorageAllocation*) [self.seigniorage_allocations objectAtIndex:0];
        [oneItem logInfo];
    }
}
@end
