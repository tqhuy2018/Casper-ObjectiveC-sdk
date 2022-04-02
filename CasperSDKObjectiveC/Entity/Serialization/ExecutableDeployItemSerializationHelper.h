#ifndef ExecutableDeployItemSerializationHelper_h
#define ExecutableDeployItemSerializationHelper_h
#import "ExecutableDeployItem.h"
#import "RuntimeArgs.h"
@interface ExecutableDeployItemSerializationHelper:NSObject
+(NSString*) serializeForExecutableDeployItem:(ExecutableDeployItem*) input;
///serialization for NameArgList, which stored in RuntimeArgs class
+(NSString *) serializeForRuntimeArgs:(RuntimeArgs*) input;
@end

#endif
