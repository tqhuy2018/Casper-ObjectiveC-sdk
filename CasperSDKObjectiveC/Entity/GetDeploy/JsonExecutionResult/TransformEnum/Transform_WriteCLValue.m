#import <Foundation/Foundation.h>
#import "Transform_WriteCLValue.h"
#import "CLValue.h"
/**Class built for storing Transform_WriteCLValue information. This class store Transform enum of type  WriteCLValue. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@implementation Transform_WriteCLValue
+(Transform_WriteCLValue*) fromJsonDictToTransform_WriteCLValue:(NSDictionary*) fromDict {
    Transform_WriteCLValue * ret = [[Transform_WriteCLValue alloc] init];
    CLValue * clValue = [[CLValue alloc] init];
    clValue = [CLValue fromJsonDictToCLValue:fromDict];
    ret.itsValue = clValue;
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform of type WriteCLValue, detail information:");
    [self.itsValue logInfo];
}
@end
