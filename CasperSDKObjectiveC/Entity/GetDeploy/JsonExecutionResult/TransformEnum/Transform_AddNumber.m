#import <Foundation/Foundation.h>
#import "Transform_AddNumber.h"
#import "ConstValues.h"
@implementation Transform_AddNumber
+(Transform_AddNumber*) fromJsonDictToTransform_AddNumber:(NSDictionary*) fromDict {
    Transform_AddNumber * ret = [[Transform_AddNumber alloc]init];
    if(!(fromDict[@"AddInt32"] == nil)) {
        ret.numberType = TRANSFORM_ADD_INT32;
        ret.numberValue = (NSString*)fromDict[@"AddInt32"];
    } else if (!(fromDict[@"AddUInt64"] == nil)) {
        ret.numberValue = (NSString*) fromDict[@"AddUInt64"];
        ret.numberType = TRANSFORM_ADD_UINT64;
    } else if (!(fromDict[@"AddUInt128"] == nil)) {
        ret.numberValue = (NSString*) fromDict[@"AddUInt128"];
        ret.numberType = TRANSFORM_ADD_UINT128;
    } else if (!(fromDict[@"AddUInt256"] == nil)) {
        ret.numberValue = (NSString*) fromDict[@"AddUInt256"];
        ret.numberType = TRANSFORM_ADD_UINT256;
    } else if (!(fromDict[@"AddUInt512"] == nil)) {
        ret.numberValue = (NSString*) fromDict[@"AddUInt512"];
        ret.numberType = TRANSFORM_ADD_UINT512;
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform type of add number, with number type:%@ and value%@",self.numberType, self.numberValue);
}
@end
