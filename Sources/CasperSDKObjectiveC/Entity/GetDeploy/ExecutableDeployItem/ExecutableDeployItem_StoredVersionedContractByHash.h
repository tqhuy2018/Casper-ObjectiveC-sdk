#ifndef ExecutableDeployItem_StoredVersionedContractByHash_h
#define ExecutableDeployItem_StoredVersionedContractByHash_h
#import "RuntimeArgs.h"
@interface ExecutableDeployItem_StoredVersionedContractByHash:NSObject
@property NSString * itsHash;
@property UInt32 version;
@property bool is_version_exists;
@property NSString * entry_point;
@property RuntimeArgs * args;
+(ExecutableDeployItem_StoredVersionedContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
