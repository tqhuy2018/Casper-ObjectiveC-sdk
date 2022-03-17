#import <Foundation/Foundation.h>
#import "CLValue.h"
#import "CLType.h"
@implementation CLValue
+(CLValue*) fromJsonDictToCLParsed:(NSDictionary*) fromDict {
    CLValue * ret = [[CLValue alloc] init];
    ret.bytes = fromDict[@"bytes"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"CLValue bytes:%@",self.bytes);
    [self.cl_type logInfo];
}
@end
