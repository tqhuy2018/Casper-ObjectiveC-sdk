#ifndef PutDeployRPC_h
#define PutDeployRPC_h
//#import <XCTest/XCTest.h>
#import "PutDeployParams.h"
#import <Foundation/Foundation.h>
@interface PutDeployRPC:NSObject
@property NSString * methodURL;
@property PutDeployParams * params;
-(void) putDeploy;
@end
#endif
