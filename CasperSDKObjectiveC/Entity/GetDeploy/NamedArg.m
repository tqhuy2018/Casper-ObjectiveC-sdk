#import <Foundation/Foundation.h>
#import "NamedArg.h"
@implementation NamedArg
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
@end
