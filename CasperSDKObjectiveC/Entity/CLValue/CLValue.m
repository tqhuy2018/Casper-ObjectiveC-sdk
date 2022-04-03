#import <Foundation/Foundation.h>
#import "CLValue.h"
#import "CLType.h"
#import "CLParsed.h"
/**Class built for storing the  CLValue object.
 Information of a sample CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 */
@implementation CLValue
///Generate the CLValue object  from the dictionary object  fromDict
+(CLValue*) fromJsonDictToCLValue:(NSDictionary*) fromDict {
    CLValue * ret = [[CLValue alloc] init];
    ret.bytes = fromDict[@"bytes"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    ret.parsed = [CLParsed fromObjToCLParsed:fromDict[@"parsed"] withCLType:ret.cl_type];
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
