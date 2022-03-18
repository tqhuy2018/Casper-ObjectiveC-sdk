#import <Foundation/Foundation.h>
#import "ExecutionResult_Success.h"
@implementation ExecutionResult_Success
+(ExecutionResult_Success*) fromJsonDictToExecutionResult_Success:(NSDictionary*) fromDict {
    ExecutionResult_Success * ret = [[ExecutionResult_Success alloc] init];
    
    NSString * costStr = (NSString*) fromDict[@"cost"];
    ret.cost = [[U512Class alloc] init];
    ret.cost = [U512Class fromStrToClass:costStr];
    
    return ret;
}
@end

