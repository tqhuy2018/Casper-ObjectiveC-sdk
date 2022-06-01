#ifndef JsonExecutionResult_h
#define JsonExecutionResult_h
#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/U512Class.h>
#import <CasperSDKObjectiveC/ExecutionEffect.h>
/**Class built for storing JsonExecutionResult information
 */
@interface JsonExecutionResult:NSObject
@property NSString * block_hash;
@property U512Class * cost;
///List of transfer, with item in the list of type string with such value "transfer-38c24e8f3871fa3d3a30db11a0a41681f030ff3dccc252da4e4ac585bb878324"
@property NSMutableArray * transfers;
@property ExecutionEffect * effect;
///Error_message, only apply for ExecutionResult_Failure
@property NSString * error_message;
@property bool is_ExecutionResult_success;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonExecutionResult object
 */
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict;
@end

#endif
