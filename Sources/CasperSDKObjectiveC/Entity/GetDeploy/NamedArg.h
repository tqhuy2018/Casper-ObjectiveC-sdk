#ifndef NamedArg_h
#define NamedArg_h
#import "CLValue.h"
/**Class built for storing NamedArg information
 */
@interface NamedArg:NSObject
@property NSString * itsName;
@property CLValue * itsCLValue;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NamedArg object
 */
+(NamedArg *) fromJsonArrayToNamedArg:(NSArray*) fromArray;
-(void) logInfo;
+(NSString *) toJsonString:(NamedArg*) fromNA;
@end

#endif
