#ifndef NamedArg_h
#define NamedArg_h
#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/CLValue.h>
/**Class built for storing NamedArg information
 */
@interface NamedArg:NSObject
@property NSString * itsName;
@property CLValue * itsCLValue;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NamedArg object
 */
+(NamedArg *) fromJsonArrayToNamedArg:(NSArray*) fromArray;
+(NSString *) toJsonString:(NamedArg*) fromNA;
@end

#endif
