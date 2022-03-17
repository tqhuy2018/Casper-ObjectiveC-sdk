#ifndef RuntimeArgs_h
#define RuntimeArgs_h

@interface RuntimeArgs:NSObject
///NamedArg list
@property NSMutableArray * listArgs;
+(RuntimeArgs*) fromJsonArrayToRuntimeArg:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif 
