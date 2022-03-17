#ifndef NamedArg_h
#define NamedArg_h
#import "CLValue.h"
@interface NamedArg:NSObject
@property NSString * itsName;
@property CLValue * itsCLValue;
+(NamedArg *) fromJsonArrayToNamedArg:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
