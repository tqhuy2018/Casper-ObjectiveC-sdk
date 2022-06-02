#ifndef PutDeployRPC_h
#define PutDeployRPC_h
//#import <XCTest/XCTest.h>
#import "PutDeployParams.h"
#import <CasperSDKObjectiveC/Deploy.h>
#import <Foundation/Foundation.h>
@interface PutDeployRPC:NSObject
@property NSString * casperURL;
@property PutDeployParams * params;
-(void) initializeWithRPCURL:(NSString*) url;
-(void) putDeployForDeploy:(Deploy*) deploy;
-(void) putDeployForDeploy:(Deploy*) deploy andCallID:(NSString*) callID;
@end
#endif
