#import <Foundation/Foundation.h>
#import "Transform_WriteBid.h"
/**Class built for storing Transform_WriteBid information. This class store Transform enum of type  WriteBid. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
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
