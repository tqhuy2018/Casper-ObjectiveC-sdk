#ifndef ExecutableDeployItem_Transfer_h
#define ExecutableDeployItem_Transfer_h

@interface ExecutableDeployItem_Transfer:NSObject
@property NSMutableArray * args;//NamedArg list
+(ExecutableDeployItem_Transfer*) fromJsonDictToObj:(NSDictionary*) fromDict;
@end

#endif 
