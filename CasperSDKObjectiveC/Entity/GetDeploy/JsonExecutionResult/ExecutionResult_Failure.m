#import <Foundation/Foundation.h>
#import "ExecutionResult_Failure.h"
#import "U512Class.h"
@implementation ExecutionResult_Failure
+(ExecutionResult_Failure*) fromJsonDictToExecutionResult_Failure:(NSDictionary*) fromDict {
    ExecutionResult_Failure * ret = [[ExecutionResult_Failure alloc] init];
    ret.error_message = fromDict[@"error_message"];
    NSString * costStr = (NSString*) fromDict[@"cost"];
    ret.cost = [[U512Class alloc] init];
    ret.cost = [U512Class fromStrToClass:costStr];
    return ret;
}
@end
