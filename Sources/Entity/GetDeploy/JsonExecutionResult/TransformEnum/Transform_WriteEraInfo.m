#import <Foundation/Foundation.h>
#import "Transform_WriteEraInfo.h"
/**Class built for storing Transform_WriteEraInfo information. This class store Transform enum of type  WriteEraInfo. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
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
