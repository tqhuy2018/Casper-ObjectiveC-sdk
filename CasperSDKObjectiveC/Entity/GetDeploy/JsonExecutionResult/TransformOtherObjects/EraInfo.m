#import <Foundation/Foundation.h>
#import "EraInfo.h"
#import "SeigniorageAllocation.h"
@implementation EraInfo
+(EraInfo*) fromJsonArrayToEraInfo:(NSArray*) fromArray {
    EraInfo * ret = [[EraInfo alloc] init];
    int totalElement = (int) fromArray.count;
    if(totalElement>0) {
        for(int i = 0; i < totalElement ; i ++) {
            //Get one  SeigniorageAllocation, then add to the list of SeigniorageAllocation
            SeigniorageAllocation * oneItem = [[SeigniorageAllocation alloc] init];
            oneItem = [SeigniorageAllocation fromJsonDictToSeigniorageAllocation:[fromArray objectAtIndex:i]];
        }
    }
    return ret;
}
-(void) logInfo {
    int totalSeigniorageAllocation = (int) self.seigniorage_allocations.count;
    NSLog(@"EraInfo, total SeigniorageAllocation:%i",totalSeigniorageAllocation);
    int counter = 0;
    if (totalSeigniorageAllocation>0) {
        counter ++;
        NSLog(@"EraInfo, information for SeigniorageAllocation item %i",counter);
        for(int i = 0 ;i< totalSeigniorageAllocation ;i ++) {
            SeigniorageAllocation * oneItem = (SeigniorageAllocation*) [self.seigniorage_allocations objectAtIndex:i];
            [oneItem logInfo];
        }
    }
}
@end
