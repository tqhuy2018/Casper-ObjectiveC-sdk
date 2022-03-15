#ifndef ExecutableDeployItem_StoredVersionedContractByName_h
#define ExecutableDeployItem_StoredVersionedContractByName_h

@interface ExecutableDeployItem_StoredVersionedContractByName:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_StoredVersionedContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif 
