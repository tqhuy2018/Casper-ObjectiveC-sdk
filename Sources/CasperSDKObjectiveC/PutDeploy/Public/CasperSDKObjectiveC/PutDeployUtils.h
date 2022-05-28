#ifndef PutDeployUtils_h
#define PutDeployUtils_h
#import <CasperSDKObjectiveC/Deploy.h>
#import <Foundation/Foundation.h>
@interface PutDeployUtils:NSObject
+(Deploy *) deploy;
+ (void) setDeploy:(Deploy *)val;
+(NSString *) secpPrivateKeyPemStr;
+ (void) setSecpPrivateKeyPemStr:(NSString *)val;
+(NSString *) rpcMethodURL;
+ (void) setRpcMethodURL:(NSString *)val;
+ (bool) isPutDeploySuccess;
+ (void) setIsPutDeploySuccess:(bool) val;
+(int) putDeployCounter;
+ (void) setPutDeployCounter:(int)val;
+(void) utilsPutDeploy;
+(void) utilsPutDeployWithCallID:(NSString*) callID;
@end
#endif
