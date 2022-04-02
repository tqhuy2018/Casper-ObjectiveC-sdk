#import <Foundation/Foundation.h>
#import "CLValue.h"
#import "CLType.h"
#import "CLParsed.h"
@implementation CLValue
+(CLValue*) fromJsonDictToCLValue:(NSDictionary*) fromDict {
    CLValue * ret = [[CLValue alloc] init];
    ret.bytes = fromDict[@"bytes"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    ret.parsed = [CLParsed fromObjToCLParsed:fromDict[@"parsed"] withCLType:ret.cl_type];
    return ret;
}
-(NSString*) serialize {
    NSString * ret = @"";
    
    return ret;
}
-(void) logInfo {
    NSLog(@"CLValue bytes:%@",self.bytes);
    NSLog(@"-----CLType info-------");
    [self.cl_type logInfo];
    NSLog(@"-----CLParsed info-------");
    [self.parsed logInfo];
}
@end
