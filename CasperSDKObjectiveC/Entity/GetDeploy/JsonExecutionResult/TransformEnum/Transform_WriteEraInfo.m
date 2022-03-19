#import <Foundation/Foundation.h>
#import "Transform_WriteEraInfo.h"
@implementation Transform_WriteEraInfo
+(Transform_WriteEraInfo*) fromJsonDictToTransform_WriteEraInfo:(NSDictionary*) fromDict {
    Transform_WriteEraInfo * ret = [[Transform_WriteEraInfo alloc] init];
    ret.itsEraInfo = [EraInfo fromJsonArrayToEraInfo:(NSArray*) fromDict[@"WriteEraInfo"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteEraInfo, information");
    [self.itsEraInfo logInfo];
}
@end
