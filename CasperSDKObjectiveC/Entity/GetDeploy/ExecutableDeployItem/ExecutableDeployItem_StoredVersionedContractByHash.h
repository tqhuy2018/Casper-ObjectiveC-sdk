#ifndef ExecutableDeployItem_StoredVersionedContractByHash_h
#define ExecutableDeployItem_StoredVersionedContractByHash_h

@interface ExecutableDeployItem_StoredVersionedContractByHash:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_StoredVersionedContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif
