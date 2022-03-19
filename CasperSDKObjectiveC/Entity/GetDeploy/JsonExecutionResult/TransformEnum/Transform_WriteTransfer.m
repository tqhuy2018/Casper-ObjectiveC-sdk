#import <Foundation/Foundation.h>
#import "Transform_WriteTransfer.h"
#import "Transfer.h"
@implementation Transform_WriteTransfer
+(Transform_WriteTransfer*) fromJsonDictToTransform_WriteTransfer:(NSDictionary*) fromDict {
    Transform_WriteTransfer * ret = [[Transform_WriteTransfer alloc] init];
    ret.itsTransfer = [Transfer fromJsonDictToTransfer:fromDict];
    return ret;
}
-(void) logInfo {
    NSLog(@"Transform_WriteTransfer information");
    [self.itsTransfer logInfo];
}

@end
