#import <Foundation/Foundation.h>
#import "Transform_WriteEraInfo.h"
@implementation Transform_WriteEraInfo
+(Transform_WriteEraInfo*) fromJsonArrayToTransform_WriteEraInfo:(NSArray*) fromDict {
    Transform_WriteEraInfo * ret = [[Transform_WriteEraInfo alloc] init];
    ret.itsEraInfo = [EraInfo fromJsonArrayToEraInfo: fromDict];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteEraInfo, information");
    [self.itsEraInfo logInfo];
}
@end
