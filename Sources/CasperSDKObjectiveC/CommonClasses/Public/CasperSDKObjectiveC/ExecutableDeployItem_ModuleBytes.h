#ifndef ExecutableDeployItem_ModuleBytes_h
#define ExecutableDeployItem_ModuleBytes_h
#import "RuntimeArgs.h"
#import <Foundation/Foundation.h>
@interface ExecutableDeployItem_ModuleBytes:NSObject
@property RuntimeArgs * args;//NamedArg list
@property NSString * module_bytes;
+(ExecutableDeployItem_ModuleBytes*) fromJsonDictToObj:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
