#import <Foundation/Foundation.h>
#import "Transform_WriteAccount.h"
@implementation Transform_WriteAccount
+(Transform_WriteAccount*) fromJsonDictToTransform_WriteAccount:(NSDictionary*) fromDict {
    Transform_WriteAccount * ret = [[Transform_WriteAccount alloc] init];
    ret.accountHash = (NSString*) fromDict[@"WriteAccount"];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform of type Write account, with account value:%@",self.accountHash);
}
@end
