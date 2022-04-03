#import <Foundation/Foundation.h>
#import "Transform_WriteTransfer.h"
#import "Transfer.h"
/**Class built for storing Transform_WriteTransfer information. This class store Transform enum of type  WriteTransfer. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
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
