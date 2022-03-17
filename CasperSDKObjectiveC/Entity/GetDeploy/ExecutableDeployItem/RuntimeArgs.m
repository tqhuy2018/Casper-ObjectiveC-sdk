#import <Foundation/Foundation.h>
#import "RuntimeArgs.h"
#import "NamedArg.h"
@implementation RuntimeArgs
+(RuntimeArgs*) fromJsonArrayToRuntimeArg:(NSArray*) fromArray {
    RuntimeArgs * ret = [[RuntimeArgs alloc] init];
    ret.listArgs = [[NSMutableArray  alloc] init];
    int totalElement = (int) fromArray.count;
    for(int i = 0 ;i < totalElement ; i++) {
        NamedArg * na = [NamedArg fromJsonArrayToNamedArg:(NSArray*) fromArray[i]];
        [ret.listArgs addObject:na];
    }
    return ret;
}
-(void) logInfo {
    int totalArgs = (int) self.listArgs.count;
    NSLog(@"RuntimeArgs, total args:%i",totalArgs);
    for(int i = 0 ; i < totalArgs ;i ++) {
        NSLog(@"RuntimeArgs, Args item index %i detail ",i);
        NamedArg * oneNA = (NamedArg*) [self.listArgs objectAtIndex:i];
        [oneNA logInfo];
    }
}
@end
