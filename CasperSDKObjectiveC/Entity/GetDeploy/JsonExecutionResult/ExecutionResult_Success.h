#ifndef ExecutionResult_Success_h
#define ExecutionResult_Success_h
#import "U512Class.h"
@interface ExecutionResult_Success:NSObject
@property U512Class * cost;
+(ExecutionResult_Success*) fromJsonDictToExecutionResult_Success:(NSDictionary*) fromDict;
@end
#endif 
