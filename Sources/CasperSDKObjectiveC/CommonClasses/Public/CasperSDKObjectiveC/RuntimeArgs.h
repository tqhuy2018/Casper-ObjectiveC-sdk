#ifndef RuntimeArgs_h
#define RuntimeArgs_h
#import <Foundation/Foundation.h>
@interface RuntimeArgs:NSObject
///NamedArg list
@property NSMutableArray * listArgs;
+(RuntimeArgs*) fromJsonArrayToRuntimeArg:(NSArray*) fromArray;
+(NSString *) toJsonString: (RuntimeArgs *) fromRA;
@end

#endif 
