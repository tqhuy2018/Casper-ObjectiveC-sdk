#ifndef ExecutionResult_Failure_h
#define ExecutionResult_Failure_h
#import "U512Class.h"
@interface ExecutionResult_Failure:NSObject
@property NSString * error_message;
@property U512Class * cost;
+(ExecutionResult_Failure*) fromJsonDictToExecutionResult_Failure:(NSDictionary*) fromDict;
@end

#endif 
