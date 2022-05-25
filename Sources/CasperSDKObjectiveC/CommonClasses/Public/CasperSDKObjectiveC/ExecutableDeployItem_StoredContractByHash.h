#ifndef ExecutableDeployItem_StoredContractByHash_h
#define ExecutableDeployItem_StoredContractByHash_h
#import "RuntimeArgs.h"
#import <Foundation/Foundation.h>
@interface ExecutableDeployItem_StoredContractByHash:NSObject
@property NSString * itsHash;
@property NSString * entry_point;
@property RuntimeArgs * args;
+(ExecutableDeployItem_StoredContractByHash*) fromJsonDictToObj:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
