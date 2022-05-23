#ifndef BigNumberSerialize_h
#define BigNumberSerialize_h
#import "QuotientNRemainder.h"
/**Class helper for serialization of big number such as UInt128, UInt256, UInt512
This class also handle the serialization of small number like u8, i32,i64,u32,u64
 */
@interface NumberSerialize:NSObject
///Function that change big number in decimal to hexa
+(NSString *) fromDecimalToHexa:(NSString*) fromNumberInStr;
///Function that find the quotient of decimal value (which can be very big number) to 16
+(QuotientNRemainder *) findQuotientAndRemainderOfStringNumber:(NSString*) fromNumberInStr;
///Function that changes number from decimal to hexa
+(NSString*) from10To16:(int) number;
///Function that changes number from decimal to hexa in bytes
+(NSString*) from10To16Bytes:(int) number;
///Function to do the work of reversing a string, used to get the correct order of the result of decimal to hexa
+(NSString*) stringReversed:(NSString*) fromString;
///Function to do the work of reversing a string, each 2 digits in a swap, used to get the correct order of the result of decimal to hexa
+(NSString*) stringReversed2Digit:(NSString*) fromString;

/**
 Serialize for CLValue of CLType U128 or U256 or U512, ingeneral the input value is called Big number
 - Parameters: value of big number  with decimal value in String format
 - Returns: Serialization for the big number, with this rule:
 - Get the hexa value from the  the decimal big number - let call it the main serialization
 - Get the length of the hexa value
 -First byte is the u8 serialization of the length, let call it prefix
 Return result = prefix + main serialization
 Special case: If input = "0" then output = "00"
 */
+(NSString*) serializeForBigNumber:(NSString*) numberInStr;

///Function for the serialization of  unsigned number  u8
+(NSString*) serializeForU8:(NSString*) numberInStr ;
///Function for the serialization of  unsigned number  u32
+(NSString*) serializeForU32:(NSString*) numberInStr ;
///Function for the serialization of  unsigned number  u64
+(NSString*) serializeForU64:(NSString*) numberInStr ;


/**
 Serialize for CLValue of CLType Int32
 - Parameters:Int32 value in String format
 - Returns: Serialization of UInt32 if input >= 0.
 If input < 0 Serialization of UInt32.max complement to the input
 */
+(NSString*) serializeForI32:(NSString*) numberInStr ;
/**
 Serialize for CLValue of CLType Int64
 - Parameters:Int64 value in String format
 - Returns: Serialization of UInt64 if input >= 0.
 If input < 0 Serialization of UInt64.max complement to the input
 */
+(NSString*) serializeForI64:(NSString*) numberInStr ;

@end

#endif
