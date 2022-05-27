#ifndef PutDeployRPC_h
#define PutDeployRPC_h
//#import <XCTest/XCTest.h>
#import "PutDeployParams.h"
#import <CasperSDKObjectiveC/Deploy.h>
#import <Foundation/Foundation.h>
@interface PutDeployRPC:NSObject
@property NSString * casperURL;
@property NSString * callID;
// This value is to check when the result of the RPC method from the POST method is ready, is valid or in error state
@property NSMutableDictionary * rpcCallGotResult;
/// This dictionary object hold the value of the returned deploy hash when call the RPC, it is used when you call the RPC from other package or other project.
@property NSMutableDictionary * valueDict;
@property PutDeployParams * params;
-(void) initializeWithRPCURL:(NSString*) url;
-(void) putDeployForDeploy:(Deploy*) deploy;
-(void) putDeployForDeploy:(Deploy*) deploy andCallID:(NSString*) callID;
-(void) putDeployWithJsonString:(NSString*) putDeployString andCallID:(NSString*) callID;
@end
#endif
