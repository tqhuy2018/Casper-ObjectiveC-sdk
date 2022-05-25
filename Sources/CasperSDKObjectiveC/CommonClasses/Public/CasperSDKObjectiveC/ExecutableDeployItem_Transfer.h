#ifndef ExecutableDeployItem_Transfer_h
#define ExecutableDeployItem_Transfer_h
#import "RuntimeArgs.h"
#import <Foundation/Foundation.h>
@interface ExecutableDeployItem_Transfer:NSObject
@property RuntimeArgs * args;
+(ExecutableDeployItem_Transfer*) fromJsonDictToObj:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
