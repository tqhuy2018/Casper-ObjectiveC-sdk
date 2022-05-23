#ifndef CLType_h
#define CLType_h
/**Class built for storing the cl_type value of a CLValue object.
 For example take this CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 Then the CLType will hold the value of U512.
 There are some more attributes in the object to store more information in its value, used to build   recursived CLType, such as List, Map, Tuple, Result, Option
 */
@interface CLType:NSObject
/// Type of the CLType, can be Bool, String, I32, I64, List, Map,...
@property NSString * itsType;
///Tag for CLType, 0 for Bool, 1 for I32, 2 for I64...
@property NSString * itsTag;
@property CLType * innerType1;
@property CLType * innerType2;
@property CLType * innerType3;
@property bool is_innerType1_exists;
@property bool is_innerType2_exists;
@property bool is_innerType3_exists;

-(NSString*) getItsType;
///Generate the CLType object  from the JSON object fromObj
+(CLType*) fromObjToCLType:(NSObject*) fromObj;
///Generate the CLType object  of type compound (type with recursive CLValue inside its body, such as List, Map, Tuple , Result ,Option...)  from the JSON object fromObj
+(CLType*) fromObjToCompoundCLType:(NSDictionary*) fromDict;
///Generate the CLType object (of type primitive (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)  from the JSON object fromObj
+(CLType*) fromObjToPrimitiveCLType:(NSObject*) fromObj;
///Check if the  CLType is primitive, type that has no recursive CLType inside (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)
-(bool) isCLTypePrimitive;
-(void) logInfo;
///Function to get the tag for CLType
+(NSString*) getTagForCLType:(CLType*) clType;
/// Function to turn 1 CLType object to Json string, used for account_put_deploy RPC method call.
+(NSString *) toJsonString:(CLType *) fromCLType;
/// Function to turn 1 CLType object of type compound to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with recursive CLType inside its body, such as List, Option, Tuple1, Tuple2, Tuple3, Result, Map.
+(NSString *) fromCLTypeCompoundToJsonString:(CLType *) fromCLType;
/// Function to turn 1 CLType object of type primitive to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with no recursive CLType inside its body, such as Bool, U8, I32, I64, U32, U64, U128....
+(NSString *) fromCLTypePrimitiveToJsonString:(CLType *) fromCLType;

@end

#endif 
