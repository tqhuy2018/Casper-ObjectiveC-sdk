#ifndef ExecutableDeployItem_StoredVersionedContractByName_h
#define ExecutableDeployItem_StoredVersionedContractByName_h
#import "RuntimeArgs.h"
#import <Foundation/Foundation.h>
@interface ExecutableDeployItem_StoredVersionedContractByName:NSObject
@property NSString * name;
@property NSString * entry_point;
@property UInt32 version;
@property bool is_version_exists;
@property RuntimeArgs * args;
+(ExecutableDeployItem_StoredVersionedContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif 
