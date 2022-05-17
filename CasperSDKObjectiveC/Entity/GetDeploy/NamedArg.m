#import <Foundation/Foundation.h>
#import "NamedArg.h"
/**Class built for storing NamedArg information
 */
@implementation NamedArg
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NamedArg object
 */
+(NamedArg *) fromJsonArrayToNamedArg:(NSArray*) fromArray {
    NamedArg * ret = [[NamedArg alloc] init];
    ret.itsName = (NSString *)[fromArray firstObject];
    NSDictionary * clValueDict = (NSDictionary*) [fromArray objectAtIndex:1];
    ret.itsCLValue = [CLValue fromJsonDictToCLValue:clValueDict];
    return  ret;
}
-(void) logInfo {
    NSLog(@"NamedArg, name:%@",self.itsName);
    NSLog(@"NamedArg, CLValue:");
    [self.itsCLValue logInfo];
}
+(NSString *) toJsonString:(NamedArg*) fromNA {
    NSString * clValueStr = [CLValue toJsonString: fromNA.itsCLValue];
    NSString * ret = [[NSString alloc] initWithFormat:@"[%@,%@]",fromNA.itsName,clValueStr];
    return ret;
    
}
@end
