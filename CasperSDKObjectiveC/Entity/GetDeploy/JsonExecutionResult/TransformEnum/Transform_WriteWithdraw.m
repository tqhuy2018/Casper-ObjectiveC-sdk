#import <Foundation/Foundation.h>
#import "Transform_WriteWithdraw.h"
#import "UnbondingPurse.h"
@implementation Transform_WriteWithdraw
+(Transform_WriteWithdraw*) fromJsonArrayToTransform_WriteWithdraw:(NSArray*) fromArray{
    Transform_WriteWithdraw * ret = [[Transform_WriteWithdraw alloc] init];
    int totalElement = (int) fromArray.count;
    if(totalElement>0) {
        ret.UnbondingPurseList = [[NSMutableArray alloc]init];
        for(int i = 0; i < totalElement; i++) {
            NSDictionary * oneItem = (NSDictionary*) [fromArray objectAtIndex:i];
            UnbondingPurse * up = [UnbondingPurse fromJsonDictToUnbondingPurse:oneItem];
            [ret.UnbondingPurseList addObject: up];
        }
    }
    return ret;
}
-(void) logInfo {
    int totalUnBondingPurse = (int) self.UnbondingPurseList.count;
    NSLog(@"Transform_WriteWithdraw,total UnbondingPurse %i",totalUnBondingPurse);
    int counter = 1;
    if(totalUnBondingPurse >0) {
        for(int i = 0; i < totalUnBondingPurse; i++) {
            NSLog(@"Transform_WriteWithdraw, item number %i information",counter);
            counter ++;
            UnbondingPurse * oneItem = (UnbondingPurse*) [self.UnbondingPurseList objectAtIndex:i];
            [oneItem logInfo];
        }
    }
}
@end
