#ifndef CLParsed_h
#define CLParsed_h
#import "CLType.h"
@interface CLParsed:NSObject

@property CLType * itsCLType;
///Type in String, for example: type of CLParsedPBool will get value of  Bool, CLParsedList will get value of List,  CLParsedMap will get value of Map, CLParsedPInt32 will get value of Int32 and so on
@property NSString * itsCLTypeStr;

@property NSString * itsPrimitiveValue;
@property NSMutableArray * arrayValue;

@property bool is_primitive;
@property bool is_array_type;

@property CLParsed * innerParsed1;
@property CLParsed * innerParsed2;
@property CLParsed * innerParsed3;

@property bool is_innerParsed1_exists;
@property bool is_innerParsed2_exists;
@property bool is_innerParsed3_exists;

+(CLParsed*) fromJsonToCLParsed:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
