#ifndef ExecutionEffect_h
#define ExecutionEffect_h
#import <Foundation/Foundation.h>
/**Class built for storing ExecutionEffect information
 */
@interface ExecutionEffect:NSObject
///List of Operation, can be empty
@property NSMutableArray * operations;
///List of TransformEntry
@property NSMutableArray * transforms;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ExecutionEffect object
 */
+(ExecutionEffect*) fromJsonDictToExecutionEffect:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
