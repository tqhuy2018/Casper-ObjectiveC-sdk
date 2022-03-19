#import <Foundation/Foundation.h>
#import "Transform_RawString.h"
#import "ConstValues.h"
@implementation Transform_RawString
+(Transform_RawString * ) fromJsonDictToTransform_RawString:(NSDictionary*) fromDict {
    Transform_RawString * ret = [[Transform_RawString alloc] init];
    if(!(fromDict[@"Identity"] == nil)) {
        ret.itsType = TRANSFORM_IDENTITY;
    } else if (!(fromDict[@"WriteContractWasm"] == nil)) {
        ret.itsType = TRANSFORM_WRITE_CONTRACT_WASM;
    } else if (!(fromDict[@"WriteContract"] == nil)) {
        ret.itsType = TRANSFORM_WRITE_CONTRACT;
    } else if (!(fromDict[@"WriteContractPackage"] == nil)) {
        ret.itsType = TRANSFORM_WRITE_CONTRACT_PACKAGE;
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform of raw string, type:%@",self.itsType);
}
@end
