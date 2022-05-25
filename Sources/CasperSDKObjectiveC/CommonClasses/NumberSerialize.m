#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/NumberSerialize.h>
/**Class helper for serialization of big number such as UInt128, UInt256, UInt512
This class also handle the serialization of small number like u8, i32,i64,u32,u64
 */
@implementation NumberSerialize
///Function for the serialization of u8 number in string format
+(NSString*) serializeForU8:(NSString *)numberInStr{
    NSString * ret = @"";
    if ([numberInStr isEqualToString:@"0"]) {
        return @"00";
    } else {
        int value = (int) [numberInStr integerValue];
        if (value < 10) {
            return [NSString stringWithFormat:@"0%i",value];
        } else {
            int remainder  = value%16;
            int quotient = (value - remainder) /16;
            NSString * remainderStr = [NumberSerialize from10To16:remainder];
            NSString  * quotientStr = [NumberSerialize from10To16:quotient];
            ret = [NSString stringWithFormat:@"%@%@",quotientStr,remainderStr];
            return ret;
        }
    }
    return ret;
}
/**
 Serialize for CLValue of CLType Int32
 - Parameters:Int32 value
 - Returns: Serialization of UInt32 if input >= 0.
 If input < 0 Serialization of UInt32.max complement to the input
 */
+(NSString*) serializeForI32:(NSString*) numberInStr {
    NSString * ret = @"";
    NSString * firstChar = [numberInStr substringToIndex:1];
    if([firstChar isEqualToString:@"-"]) {
        //is negative number, then get positive value
        int value = (int) [numberInStr integerValue];
        uint32_t  max = UINT32_MAX;
        uint32_t remain = max + value + 1;
        NSString * valueInStr = [NSString stringWithFormat:@"%u",remain];
        ret = [NumberSerialize serializeForU32:valueInStr];
    } else {//is positive number, then just get the serialization like u32
        ret = [NumberSerialize serializeForU32:numberInStr];
    }
    return ret;
}
/**
 Serialize for CLValue of CLType Int64
 - Parameters:Int64 value in String format
 - Returns: Serialization of UInt64 if input >= 0.
 If input < 0 Serialization of UInt64.max complement to the input
 */
+(NSString*) serializeForI64:(NSString*) numberInStr {
    NSString * ret = @"";
    NSString * firstChar = [numberInStr substringToIndex:1];
    if([firstChar isEqualToString:@"-"]) {
        //is negative number, then get positive value
        uint64_t value = (uint64_t) [numberInStr longLongValue];
        uint64_t  max = UINT64_MAX;
        uint64_t remain = max + value + 1;
        NSString * valueInStr = [NSString stringWithFormat:@"%llu",remain];
        ret = [NumberSerialize serializeForU64:valueInStr];
    } else {//is positive number, then just get the serialization like u32
        ret = [NumberSerialize serializeForU64:numberInStr];
    }
    return ret;
}
///Function for the serialization of small unsigned number  u32
+(NSString*) serializeForU32:(NSString*) numberInStr {
    NSString * ret = @"";
    if ([numberInStr isEqualToString:@"0"]) {
        return @"00000000";
    } else {
        ret = [NumberSerialize fromDecimalToHexa:numberInStr];
    }
    int retLength = (int) [ret length];
    if (retLength < 8) {
        int total0Added = 8 - retLength;
        NSString * prefix0 = @"";
        for(int i = 0 ; i < total0Added; i ++) {
            prefix0 = [NSString stringWithFormat:@"%@0",prefix0];
        }
        ret = [NSString stringWithFormat:@"%@%@",prefix0,ret];
    }
    ret = [NumberSerialize stringReversed2Digit:ret];
    return  ret;
}
///Function for the serialization of small unsigned number  u64
+(NSString*) serializeForU64:(NSString*) numberInStr  {
    NSString * ret = @"";
    if ([numberInStr isEqualToString:@"0"]) {
        return @"0000000000000000";
    } else {
        ret = [NumberSerialize fromDecimalToHexa:numberInStr];
    }
    int retLength = (int) [ret length];
    if (retLength < 16) {
        int total0Added = 16 - retLength;
        NSString * prefix0 = @"";
        for(int i = 0 ; i < total0Added; i ++) {
            prefix0 = [NSString stringWithFormat:@"%@0",prefix0];
        }
        ret = [NSString stringWithFormat:@"%@%@",prefix0,ret];
    }
    ret = [NumberSerialize stringReversed2Digit:ret];
    return  ret;
}

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
+(NSString*) serializeForBigNumber:(NSString*) numberInStr {
    NSString * ret = @"";
    if ([numberInStr isEqualToString:@"0"]) {
        return @"00";
    }
    ret = [NumberSerialize fromDecimalToHexa:numberInStr];
    int retLength = (int) [ret length];
    int retLengthBytes = 0;
    if (retLength%2 == 1) {
        ret = [NSString stringWithFormat:@"0%@",ret];
        retLengthBytes = (retLength + 1) /2;
    } else {
        retLengthBytes = retLength/2;
    }
    NSString * prefixLength = [NumberSerialize serializeForU8:[NSString stringWithFormat:@"%i",retLengthBytes]];
    ret = [NumberSerialize stringReversed2Digit:ret];
    ret = [NSString stringWithFormat:@"%@%@",prefixLength,ret];
    return ret;
}
///Function that find the quotient of decimal value (which can be very big number) to 16
+(QuotientNRemainder *) findQuotientAndRemainderOfStringNumber:(NSString*) fromNumberInStr {
    QuotientNRemainder * retQR = [[QuotientNRemainder alloc]init];
    NSString * ret = @"";
    int strLength = (int) [fromNumberInStr length];
    int startIndex = 0;
    int remainder = 0;
    if (strLength < 2) {
        int value = (int) [fromNumberInStr integerValue];
        NSString * valueHexa = [NumberSerialize from10To16:value];
        ret = valueHexa;
        retQR.quotient = @"0";
        retQR.remainder = value;
        return retQR;
    } else if (strLength == 2) {
        int value = (int) [fromNumberInStr integerValue];
        remainder = value%16;
        int quotient = (value - remainder) / 16;
        ret = [NSString stringWithFormat:@"%i",quotient];
        retQR.quotient = ret;
        retQR.remainder = remainder;
        return retQR;
    } else { // string length >=3
        //take first 2 characters
        startIndex = 2;
        NSString * first2 = [fromNumberInStr substringToIndex:2];
        int value = (int) [first2 integerValue];
        if (value < 16) {
            startIndex = 3;
            //take 3 character
            NSString * first3 = [fromNumberInStr substringToIndex:3];
            int value = (int) [first3 integerValue];
            remainder = value%16;
            int quotient = (value - remainder) / 16;
            ret = [NumberSerialize from10To16:quotient];
        } else {
            startIndex = 2;
            int value = (int) [first2 integerValue];
            remainder = value%16;
            int quotient = (value - remainder) / 16;
            ret = [NumberSerialize from10To16:quotient];
        }
        while(startIndex < strLength) {
            NSString * nextChar  = [fromNumberInStr substringWithRange:NSMakeRange(startIndex,1)];
            int nextCharValue = (int) [nextChar integerValue];
            int nextValue = remainder * 10 + nextCharValue;
            if(nextValue<16) {
                if(startIndex + 2 <= strLength) {
                    ret = [NSString stringWithFormat:@"%@0",ret];
                    NSString * nextChar  = [fromNumberInStr substringWithRange:NSMakeRange(startIndex,2)];
                    int nextCharValue = (int) [nextChar integerValue];
                    int nextValue = remainder * 100 + nextCharValue;
                    remainder = nextValue % 16;
                    int quotient = (nextValue - remainder) / 16;
                    NSString * nextCharInRet = [NumberSerialize from10To16:quotient];
                    ret = [NSString stringWithFormat:@"%@%@",ret,nextCharInRet];
                    startIndex += 2;
                } else {
                    int remainChar = strLength - startIndex;
                    if(remainChar == 1) {
                        ret = [NSString stringWithFormat:@"%@0",ret];
                    } else if (remainChar == 2) {
                        ret = [NSString stringWithFormat:@"%@00",ret];
                    }
                    remainder = nextValue;
                    strLength = 0;
                }
            } else {
                remainder = nextValue % 16;
                int quotient = (nextValue - remainder) / 16;
                NSString * nextCharInRet = [NumberSerialize from10To16:quotient];
                ret = [NSString stringWithFormat:@"%@%@",ret,nextCharInRet];
                startIndex += 1;
            }
        }
    }
    retQR.quotient = ret;
    retQR.remainder = remainder;
    return retQR;
}


+(NSString *) fromDecimalToHexa:(NSString*) fromNumberInStr {
    NSString * ret = @"";
    QuotientNRemainder * ret1 = [NumberSerialize findQuotientAndRemainderOfStringNumber:fromNumberInStr];
    int numberLength = (int) [ret1.quotient length];
    NSString * bigNumber = ret1.quotient;
    NSString * remainderStr = [NumberSerialize from10To16:ret1.remainder];
    ret = remainderStr;
    NSString * lastQuotient = @"";
    if(numberLength<2) {
        lastQuotient = ret1.quotient;
    }
    while(numberLength>=2) {
        QuotientNRemainder * retN = [NumberSerialize findQuotientAndRemainderOfStringNumber:bigNumber];
        numberLength = (int) [retN.quotient length];
        bigNumber = retN.quotient;
        NSString * remainderStr = [NumberSerialize from10To16:retN.remainder];
        ret = [NSString stringWithFormat:@"%@%@",ret, remainderStr];
        lastQuotient = retN.quotient;
    }
    if ([lastQuotient isEqualToString:@"0"]) {
    } else {
        ret = [NSString stringWithFormat:@"%@%@",ret,lastQuotient];
    }
    ret = [NumberSerialize stringReversed:ret];
    return ret;
}
///Function that changes number from decimal to hexa in bytes
+(NSString*) from10To16Bytes:(int) number {
    if (number<10) {
        return [NSString stringWithFormat:@"0%i",number];
    } else if (number == 10) {
        return @"0a";
    } else if (number == 11) {
        return @"0b";
    } else if (number == 12) {
        return @"0c";
    } else if (number == 13) {
        return @"0d";
    } else if (number == 14) {
        return @"0e";
    } else if (number == 15) {
        return  @"0f";
    }
    return @"NONE";
}
///Function that changes number from decimal to hexa
+(NSString*) from10To16:(int) number  {
    if (number<10) {
        return [NSString stringWithFormat:@"%i",number];
    } else if (number == 10) {
        return @"a";
    } else if (number == 11) {
        return @"b";
    } else if (number == 12) {
        return @"c";
    } else if (number == 13) {
        return @"d";
    } else if (number == 14) {
        return @"e";
    } else if (number == 15) {
        return  @"f";
    }
    return @"NONE";
}

///Function to do the work of reversing a string, each 2 digits in a swap, used to get the correct order of the result of decimal to hexa
+(NSString*) stringReversed2Digit:(NSString*) fromString {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [fromString length];
    while (charIndex > 0) {
        charIndex -= 2;
        NSRange subStrRange = NSMakeRange(charIndex, 2);
        [reversedString appendString:[fromString substringWithRange:subStrRange]];
    }
    return  reversedString;
}
///Function to do the work of reversing a string, used to get the correct order of the result of decimal to hexa
+(NSString*) stringReversed:(NSString*) fromString {
    NSMutableString *reversedString = [NSMutableString string];
    NSInteger charIndex = [fromString length];
    while (charIndex > 0) {
        charIndex--;
        NSRange subStrRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[fromString substringWithRange:subStrRange]];
    }
    return  reversedString;
}
@end
