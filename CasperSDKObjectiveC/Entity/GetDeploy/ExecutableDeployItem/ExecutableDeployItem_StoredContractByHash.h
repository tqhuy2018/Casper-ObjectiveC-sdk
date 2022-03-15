#ifndef ExecutableDeployItem_StoredContractByHash_h
#define ExecutableDeployItem_StoredContractByHash_h
@interface ExecutableDeployItem_StoredContractByHash:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_StoredContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif
