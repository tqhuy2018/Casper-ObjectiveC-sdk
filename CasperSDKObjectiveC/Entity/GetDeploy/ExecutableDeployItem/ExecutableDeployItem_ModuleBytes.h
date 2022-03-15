#ifndef ExecutableDeployItem_ModuleBytes_h
#define ExecutableDeployItem_ModuleBytes_h
@interface ExecutableDeployItem_ModuleBytes:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_ModuleBytes*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif
