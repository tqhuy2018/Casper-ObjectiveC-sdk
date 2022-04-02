#ifndef CLParseSerializeHelper_h
#define CLParseSerializeHelper_h
#import "CLParsed.h"
///Class for serialization of CLValue parse value
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
+(NSString*) serializeFromCLParseKey:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  URef
+(NSString*) serializeFromCLParseURef:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  PublicKey, simply return the PublicKey value
+(NSString*) serializeFromCLParsePublicKey:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  ByteArray,, simply return the ByteArray value
+(NSString*) serializeFromCLParseByteArray:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Option
+(NSString*) serializeFromCLParseOption:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  List
+(NSString*) serializeFromCLParseList:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Map
+(NSString*) serializeFromCLParseMap:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Result
+(NSString*) serializeFromCLParseResult:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple1
+(NSString*) serializeFromCLParseTuple1:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple2
+(NSString*) serializeFromCLParseTuple2:(CLParsed*) fromCLParse;

///This function serialize  CLValue of type  Tuple3
+(NSString*) serializeFromCLParseTuple3:(CLParsed*) fromCLParse;
@end

#endif
