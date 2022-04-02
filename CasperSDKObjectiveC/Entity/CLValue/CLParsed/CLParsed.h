#ifndef CLParsed_h
#define CLParsed_h
#import "CLType.h"
@interface CLParsed:NSObject

@property CLType * itsCLType;
///Type in String, for example: type of CLParsedPBool will get value of  Bool, CLParsedList will get value of List,  CLParsedMap will get value of Map, CLParsedPInt32 will get value of Int32 and so on
@property NSString * itsCLTypeStr;

@property NSString * itsPrimitiveValue;
//This value is for CLType primitive value

//For CLParse Result, itsValueStr = Ok or Err, for other type such as primitive bool, the value will be "true" or "false"
@property NSString * itsValueStr;

//This value is used for List and FixedList
@property NSMutableArray * arrayValue;

@property bool is_primitive;
@property bool is_array_type;
//innerParsed for compound types
//For Tuple1, Result and Option CLType, innerParsed1 value is used
//For Tuple2 CLType, innerParsed1,innerParsed2 value are used
//For tuple3 CLType, innerParsed1,innerParsed2,innerParsed3 value are used

//For map CLType, key is stored in innerParsed1, value is stored in innerParsed2 and the innerParsed1 is a ParseList with values stored in arrayValue
@property CLParsed * innerParsed1;
@property CLParsed * innerParsed2;
@property CLParsed * innerParsed3;

@property bool is_innerParsed1_exists;
@property bool is_innerParsed2_exists;
@property bool is_innerParsed3_exists;

+(CLParsed*) fromObjToCLParsed:(NSObject*) fromObj withCLType:(CLType*) clType;
+(CLParsed*) fromObjToCLParsedPrimitive:(NSObject*) fromObj withCLType:(CLType*) clType;
+(CLParsed*) fromObjToCLParsedCompound:(NSObject*) fromObj withCLType:(CLType*) clType;
+(CLParsed*) clParsedWithType:(NSString*) type andValue:(NSString*) value;
-(void) logInfo;
-(bool) isPrimitive;
@end

#endif
