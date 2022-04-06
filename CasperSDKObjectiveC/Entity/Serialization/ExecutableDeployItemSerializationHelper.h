#ifndef ExecutableDeployItemSerializationHelper_h
#define ExecutableDeployItemSerializationHelper_h
#import "ExecutableDeployItem.h"
#import "RuntimeArgs.h"
/**
 This class do the work of serialize the ExecutableDeployItem object, which is an enum type object
 */
@interface ExecutableDeployItemSerializationHelper:NSObject
///This function do the serialization for ExecutableDeployItem, which can be among 1 of 6 value type: ModuleBytes, StoredContractByHash, StoredContractByName, StoredVersionedContractByHash, StoredVersionedContractByName, Transfer
///The detail of each value type serialization is decribed in the function implementation.
+(NSString*) serializeForExecutableDeployItem:(ExecutableDeployItem*) input;
///This function do the serialization for NameArgList, which stored in RuntimeArgs class,
///The detail of the serialization rule is described in the function implementation
+(NSString *) serializeForRuntimeArgs:(RuntimeArgs*) input;
@end

#endif
