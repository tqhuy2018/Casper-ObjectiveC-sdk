#ifndef PutDeployRPC_h
#define PutDeployRPC_h
#import <XCTest/XCTest.h>
#import "PutDeployParams.h"
@interface PutDeployRPC:XCTestCase
@property NSString * methodURL;
@property PutDeployParams * params;
-(void) putDeploy;
@end
#endif
