#ifndef CLParsed_h
#define CLParsed_h
#import "CLType.h"
/**Class built for storing the parse value of a CLValue object.
 For example take this CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 Then the parse will hold the value of 100000000.
 There are some more attributes in the object to store more information on the type of the parse (CLType), its value in String for later handle in serialization or show the information
 */
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
///Generate the CLParse object  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsed:(NSObject*) fromObj withCLType:(CLType*) clType;
///Generate the CLParse object  of type primitive (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsedPrimitive:(NSObject*) fromObj withCLType:(CLType*) clType;
///Generate the CLParse object  of type compound (type with recursive CLValue inside its body, such as List, Map, Tuple , Result ,Option...)  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsedCompound:(NSObject*) fromObj withCLType:(CLType*) clType;
///Generate the CLParse object with given information of Type and value
+(CLParsed*) clParsedWithType:(NSString*) type andValue:(NSString*) value;
///Check if the CLParse from CLType primitive, type that has no recursive CLType inside (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)
-(bool) isPrimitive;
-(void) logInfo;
/// Function to turn CLParsed object to Json string, used for account_put_deploy RPC method call.
+(NSString *) toJsonString:(CLParsed *) fromCLParsed;
/// Function to turn 1 CLParsed object of type CLType compound to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with recursive CLType inside its body, such as List, Option, Tuple1, Tuple2, Tuple3, Result, Map.
+(NSString *) fromCompoundParsedToJsonString:(CLParsed *) fromCLParsed;
/// Function to turn 1 CLType object of type primitive to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with no recursive CLType inside its body, such as Bool, U8, I32, I64, U32, U64, U128....
+(NSString *) fromPrimitiveParsedToJsonString:(CLParsed *) fromCLParsed;
@end

#endif
