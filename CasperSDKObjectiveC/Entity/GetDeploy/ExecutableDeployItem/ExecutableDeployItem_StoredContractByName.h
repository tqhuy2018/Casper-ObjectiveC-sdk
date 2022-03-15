#ifndef ExecutableDeployItem_StoredContractByName_h
#define ExecutableDeployItem_StoredContractByName_h

@interface ExecutableDeployItem_StoredContractByName:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_StoredContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif 
