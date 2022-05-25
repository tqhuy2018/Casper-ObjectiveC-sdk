#import <Foundation/Foundation.h>
#ifndef ObjectToJsonStringHelper_h
#define ObjectToJsonStringHelper_h
#import <CasperSDKObjectiveC/CLValue.h>
#import <CasperSDKObjectiveC/NamedArg.h>
@interface ObjectToJsonStringHelper:NSObject
/// Function to turn 1 CLValue object to Json string, used for account_put_deploy RPC method call.
+(NSString *) clValueToJsonString:(CLValue *) fromCLValue;
+(NSString *) namedArgToJsonString:(NamedArg*) fromNA ;
@end
#endif
