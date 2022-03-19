#import <Foundation/Foundation.h>
#import "Transform_Failure.h"
@implementation Transform_Failure
+(Transform_Failure*) fromJsonDictToTransform_Failure:(NSDictionary*) fromDict {
    Transform_Failure * ret = [[Transform_Failure alloc] init];
    ret.itsValue = fromDict[@"Failure"];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform of type Failure, with Failure value:%@",self.itsValue);
}
@end
