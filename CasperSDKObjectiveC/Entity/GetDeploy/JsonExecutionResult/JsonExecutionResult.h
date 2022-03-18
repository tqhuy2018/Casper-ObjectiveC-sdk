#ifndef JsonExecutionResult_h
#define JsonExecutionResult_h
@interface JsonExecutionResult:NSObject
@property NSString * block_hash;
///This property only hold 1 item, which can be ExecutionResult_Failure or ExecutionResult_Success
@property NSMutableArray * result;
@property bool is_ExecutionResult_success;
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict;
@end

#endif
