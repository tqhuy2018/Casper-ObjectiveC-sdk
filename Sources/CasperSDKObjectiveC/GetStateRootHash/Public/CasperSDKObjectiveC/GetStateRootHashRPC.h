#ifndef GetStateRootHashRPC_h
#define GetStateRootHashRPC_h
#import <Foundation/Foundation.h>
@interface GetStateRootHashRPC:NSObject
@property NSString * methodURL;
-(void) setMethodURL:(NSString*) url;
-(void) getStateRootHashWithJsonParam:(NSString*) jsonString;
@end
#endif
