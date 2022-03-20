#ifndef JsonExecutionResult_h
#define JsonExecutionResult_h
#import "U512Class.h"
#import "ExecutionEffect.h"
@interface JsonExecutionResult:NSObject
@property NSString * block_hash;
@property U512Class * cost;
///List of transfer, with item in the list of type string with such value "transfer-38c24e8f3871fa3d3a30db11a0a41681f030ff3dccc252da4e4ac585bb878324"
@property NSMutableArray * transfers;
@property ExecutionEffect * effect;
///Error_message, only apply for ExecutionResult_Failure
@property NSString * error_message;
@property bool is_ExecutionResult_success;
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
