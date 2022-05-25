#ifndef CLParseSerializeHelper_h
#define CLParseSerializeHelper_h
#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/CLParsed.h>
/**Class for serialization of CLValue parse value
 For example take this CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 Then the parse will hold the value of 100000000.
 This class will serialize the value of 100000000 based on its CLValue type, which is U512
 */
@interface CLParseSerializeHelper:NSObject

///Function for the serialization of  CLParse in general
+(NSString*) serializeFromCLParse:(CLParsed*) fromCLParse;

///Function for the serialization of  CLParse primitive in type with no recursive CLValue inside, such as Bool, U8, U32, I32, String, ....
+(NSString*) serializeFromCLParsePrimitive:(CLParsed*) fromCLParse;

///Function for the serialization of  CLParse compound in type with  recursive CLValue inside, such as Option, List, Map, Tuple1, Tuple2, Tuple3
+(NSString*) serializeFromCLParseCompound:(CLParsed*) fromCLParse;

///Function for the serialization of  Bool value
+(NSString*) serializeFromCLParseBool:(CLParsed*) fromCLParse;

///Function for the serialization of  unsigned number  u8
+(NSString*) serializeFromCLParseU8:(CLParsed*) fromCLParse;

///Function for the serialization of  unsigned number  u32
+(NSString*) serializeFromCLParseU32:(CLParsed*) fromCLParse;

///Function for the serialization of  unsigned number  u64
+(NSString*) serializeFromCLParseU64:(CLParsed*) fromCLParse;

/**
 Serialize for CLValue of CLType U128 or U256 or U512, ingeneral the input value is called Big number
 - Parameters: value of big number  with decimal value in String format
 - Returns: Serialization for the big number, with this rule:
 - Get the hexa value from the  the decimal big number - let call it the main serialization
 - Get the length of the hexa value
 -First byte is the u8 serialization of the length, let call it prefix
 Return result = prefix + main serialization
 Special case: If input = "0" then output = "00"
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseBigNumber:(CLParsed*) fromCLParse;

/**
 Serialize for CLValue of CLType Int32
 - Parameters:Int32 value in String format
 - Returns: Serialization of UInt32 if input >= 0.
 If input < 0 Serialization of UInt32.max complement to the input
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseInt32:(CLParsed*) fromCLParse;

/**
 Serialize for CLValue of CLType Int64
 - Parameters:Int64 value in String format
 - Returns: Serialization of UInt64 if input >= 0.
 If input < 0 Serialization of UInt64.max complement to the input
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseInt64:(CLParsed*) fromCLParse;

///This function serialize CLValue of type String
+(NSString*) serializeFromCLParseString:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Unit, just return empty string
+(NSString*) serializeFromCLParseUnit:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Key
///Rule for serialization:
///For type of account hash: "00" + value drop the prefix "account-hash-"
///For type hash: "01" + value drop the prefix "hash-"
///For type URef: same like CLValue of CLType URef serialization
+(NSString*) serializeFromCLParseKey:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  URef
///Sample serialization for value : uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007
///Return result will be be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607
+(NSString*) serializeFromCLParseURef:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  PublicKey, simply return the PublicKey value
+(NSString*) serializeFromCLParsePublicKey:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  ByteArray,, simply return the ByteArray value
+(NSString*) serializeFromCLParseByteArray:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Option
///Rule for Option serialization:
///If the value inside the Option is Null, return "00"
///else return "01" + (Option.inner parse value).serialization
+(NSString*) serializeFromCLParseOption:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  List
///Rule for List serialization:
///If the list is empty, return ""
///If the list is not empty, first get the list size, and then get the U32 serialization of the list size, let call it lengthSerialization
///result = lengthSerialization + concatenation of (each element in List).serialized
+(NSString*) serializeFromCLParseList:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Map, the rule for serialization:
///If the map is empty return "00000000"
///else
///First get the size of the map, then get the U32.serialize of the map size, let call it lengthSerialization
///For 1 pair (key,value) the serialization is key.serialization + value.serialization
///map.serialization = lengthSerialization +  concatenation of all pair(key,value)
+(NSString*) serializeFromCLParseMap:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Result, the rule is:
///If the result is Ok, then the prefix = "01"
///If the result is Err, then the prefix = "00"
///result = prefix + (inner CLParse value).serialized
+(NSString*) serializeFromCLParseResult:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple1, the result is the serialization of the CLParse inner value in the Tuple1
+(NSString*) serializeFromCLParseTuple1:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple2,  the result is the concatenation of 2 inner CLParse values in the Tuple2
+(NSString*) serializeFromCLParseTuple2:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple3, the result is the concatenation of 3 inner CLParse values in the Tuple3
+(NSString*) serializeFromCLParseTuple3:(CLParsed*) fromCLParse;
@end

#endif
