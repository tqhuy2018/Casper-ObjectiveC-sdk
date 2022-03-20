#import <Foundation/Foundation.h>
#import "Transform_WriteBid.h"
@implementation Transform_WriteBid
+(Transform_WriteBid*) fromJsonDictToTransform_WriteBid:(NSDictionary*) fromDict {
    Transform_WriteBid * ret = [[Transform_WriteBid alloc] init];
    ret.bidValue = [Bid fromJsonDictToBid:fromDict];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteBid information:");
    [self.bidValue logInfo];
}
@end
