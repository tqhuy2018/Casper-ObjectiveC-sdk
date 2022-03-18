#ifndef ExecutionEffect_h
#define ExecutionEffect_h
@interface ExecutionEffect:NSObject
///List of Operation, can be empty
@property NSMutableArray * operations;
///List of TransformEntry
@property NSMutableArray * transforms;
+(ExecutionEffect*) fromJsonDictToExecutionEffect:(NSDictionary*) fromDict;
@end

#endif
