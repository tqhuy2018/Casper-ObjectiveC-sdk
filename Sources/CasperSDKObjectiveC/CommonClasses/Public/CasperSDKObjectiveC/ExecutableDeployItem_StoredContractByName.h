#ifndef ExecutableDeployItem_StoredContractByName_h
#define ExecutableDeployItem_StoredContractByName_h
#import "RuntimeArgs.h"
#import <Foundation/Foundation.h>
@interface ExecutableDeployItem_StoredContractByName:NSObject
@property NSString * name;
@property NSString * entry_point;
@property RuntimeArgs * args;
+(ExecutableDeployItem_StoredContractByName*) fromJsonDictToObj:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
