#import <Foundation/Foundation.h>
#import "PutDeployParams.h"
//#import <CasperSDKObjectiveC/CasperSDKObjectiveC-Swift.h>
@import CasperCryptoHandlePackage;
@implementation PutDeployParams
-(NSString*) generateParamString {
    NSString * deployJsonString = [self.deploy toPutDeployParameterStr];
    return deployJsonString;
}
@end
