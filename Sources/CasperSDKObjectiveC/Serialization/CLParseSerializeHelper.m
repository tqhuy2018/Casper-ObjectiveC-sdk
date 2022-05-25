#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/CLParseSerializeHelper.h>
#import <CasperSDKObjectiveC/NumberSerialize.h>
#import <CasperSDKObjectiveC/ConstValues.h>
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
@implementation CLParseSerializeHelper
///Serialization for Bool parsed value
+(NSString*) serializeFromCLParseBool:(CLParsed*) fromCLParse {
    if ([fromCLParse.itsValueStr isEqualToString: @"true"]) {
        return @"01";
    } else {
        return @"00";
    }
}
///Serialization for U8 parsed value

+(NSString*) serializeFromCLParseU8:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForU8:fromCLParse.itsValueStr];
    return ret;
}
///Serialization for U32 parsed value

+(NSString*) serializeFromCLParseU32:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForU32:fromCLParse.itsValueStr];
    return ret;
}
///Serialization for U64 parsed value

+(NSString*) serializeFromCLParseU64:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForU64:fromCLParse.itsValueStr];
    return ret;
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
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseBigNumber:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForBigNumber:fromCLParse.itsValueStr];
    return ret;
}
/**
 Serialize for CLValue of CLType Int32
 - Parameters:Int32 value in String format
 - Returns: Serialization of UInt32 if input >= 0.
 If input < 0 Serialization of UInt32.max complement to the input
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseInt32:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForI32:fromCLParse.itsValueStr];
    return ret;
}
/**
 Serialize for CLValue of CLType Int64
 - Parameters:Int64 value in String format
 - Returns: Serialization of UInt64 if input >= 0.
 If input < 0 Serialization of UInt64.max complement to the input
 This function just call the NumberSerialize class method to get the result, the actual code is implemented in NumberSerialize class
 */
+(NSString*) serializeFromCLParseInt64:(CLParsed*) fromCLParse {
    NSString * ret = [NumberSerialize serializeForI64:fromCLParse.itsValueStr];
    return ret;
}
///This function serialize String
+(NSString*) serializeFromCLParseString:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    NSString * stringToParse = fromCLParse.itsValueStr;
    int strLength = (int) [stringToParse length];
    ret = [NumberSerialize serializeForU32:[NSString stringWithFormat:@"%i",strLength]];
    for(int i = 0 ; i < strLength ; i ++) {
        //NSString * oneChar = [stringToParse substringWithRange:NSMakeRange(i, 1)];
        unichar ch = [stringToParse characterAtIndex:i];
        int code = (int)ch;
        NSString * oneCharCode = [NumberSerialize serializeForU8:[NSString stringWithFormat:@"%i",code]];
        ret = [NSString stringWithFormat:@"%@%@",ret,oneCharCode];
    }
    return ret;
}
///This function serialize  CLValue of type  Unit, just return empty string
+(NSString*) serializeFromCLParseUnit:(CLParsed*) fromCLParse {
    return @"";
}
///This function serialize  CLValue of type  Key
///Rule for serialization:
///For type of account hash: "00" + value drop the prefix "account-hash-"
///For type hash: "01" + value drop the prefix "hash-"
///For type URef: same like CLValue of CLType URef serialization
+(NSString*) serializeFromCLParseKey:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    NSString * keyStr = fromCLParse.itsValueStr;
    if ([keyStr containsString:@"account-hash-"]) {
        NSArray * arr = [keyStr componentsSeparatedByString:@"-"];
        ret = [NSString stringWithFormat:@"00%@",(NSString*) arr[2]];
    } else if ([keyStr containsString:@"hash-"]) {
        NSArray * arr = [keyStr componentsSeparatedByString:@"-"];
        ret = [NSString stringWithFormat:@"01%@",(NSString*) arr[1]];
    } else if ([keyStr containsString:@"uref-"]) {
        NSArray * arr = [keyStr componentsSeparatedByString:@"-"];
        ret = [NSString stringWithFormat:@"02%@",(NSString*) arr[1]];
        NSString * suffix = [(NSString*)arr[2] substringWithRange:NSMakeRange(1,2)];
        ret = [NSString stringWithFormat:@"%@%@",ret,suffix];
    }
    return ret;
}
///This function serialize  CLValue of type  URef
///Sample serialization for value : uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007
///Return result will be be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607
+(NSString*) serializeFromCLParseURef:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    NSString * keyStr = fromCLParse.itsValueStr;
    if ([keyStr containsString:@"uref-"]) {
        NSArray * arr = [keyStr componentsSeparatedByString:@"-"];
        ret = (NSString*) arr[1];
        NSString * suffix = [(NSString*)arr[2] substringWithRange:NSMakeRange(1,2)];
        ret = [NSString stringWithFormat:@"%@%@",ret,suffix];
    } else {
        ret = @"NONE_URef";
    }
    return ret;
}

///This function serialize  CLValue of type  PublicKey, just return the PublicKey value
+(NSString*) serializeFromCLParsePublicKey:(CLParsed*) fromCLParse {
    return fromCLParse.itsValueStr;
}
///This function serialize  CLValue of type  ByteArray,, simply return the ByteArray value
+(NSString*) serializeFromCLParseByteArray:(CLParsed*) fromCLParse {
    return fromCLParse.itsValueStr;
}
///This function serialize  CLValue of type  Option
///Rule for Option serialization:
///If the value inside the Option is Null, return "00"
///else return "01" + (Option.inner parse value).serialization
+(NSString*) serializeFromCLParseOption:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    if([fromCLParse.itsValueStr isEqualToString:CLPARSED_NULL_VALUE]) {
        return @"00";
    }
    NSString * innerParsedSerialization = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed1];
    ret = [NSString stringWithFormat:@"01%@",innerParsedSerialization];
    return ret;
}

///This function serialize  CLValue of type  List
+(NSString*) serializeFromCLParseList:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    int totalElement = (int) [fromCLParse.arrayValue count];
    if (totalElement == 0) {
        return @"";
    }
    ret = [NumberSerialize serializeForU32:[NSString stringWithFormat:@"%i",totalElement]];
    for(int i = 0 ; i < totalElement; i ++) {
        NSString * oneSerialization = [CLParseSerializeHelper serializeFromCLParse:(CLParsed *) [fromCLParse.arrayValue objectAtIndex:i]];
        ret = [NSString stringWithFormat:@"%@%@",ret,oneSerialization];
    }
    return ret;
}
///This function serialize  CLValue of type  Map, the rule for serialization:
///If the map is empty return "00000000"
///else
///First get the size of the map, then get the U32.serialize of the map size, let call it lengthSerialization
///For 1 pair (key,value) the serialization is key.serialization + value.serialization
///map.serialization = lengthSerialization +  concatenation of all pair(key,value)
+(NSString*) serializeFromCLParseMap:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    //Value of CLParseMap is stored with innerParsed1 and innerParsed2  as List taken into used, for key and value array
    int totalElement = (int)[fromCLParse.innerParsed1.arrayValue count] ;
    //If the map is empty, just return "00000000"
    if (totalElement == 0) {
        return @"00000000";
    }
    //If the map is not empty, concatenation the serialization of each key-value and then add the prefix of U32 serialization for total element of the map
    //need to sort the array in ascending order based on the key array, obmit this step first since the result from sever is in sorted order
    ret = [NumberSerialize serializeForU32:[NSString stringWithFormat:@"%i",totalElement]];
    for(int i = 0 ; i < totalElement; i++) {
        NSString * keySerialization = [CLParseSerializeHelper serializeFromCLParse:(CLParsed *)[fromCLParse.innerParsed1.arrayValue objectAtIndex:i]];
        NSString * valueSerialization = [CLParseSerializeHelper serializeFromCLParse:(CLParsed *)[fromCLParse.innerParsed2.arrayValue objectAtIndex:i]];
        ret = [NSString stringWithFormat:@"%@%@%@",ret,keySerialization,valueSerialization];
    }
    return ret;
}
///This function serialize  CLValue of type  Result, the rule is:
///If the result is Ok, then the prefix = "01"
///If the result is Err, then the prefix = "00"
///result = prefix + (inner CLParse value).serialized
+(NSString*) serializeFromCLParseResult:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    NSString * prefix = @"";
    if([fromCLParse.itsValueStr isEqualToString:CLPARSED_RESULT_OK]) {
        prefix = @"01";
    } else {
        prefix = @"00";
    }
    ret = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed1];
    ret = [NSString stringWithFormat:@"%@%@",prefix,ret];
    return ret;
}

///This function serialize  CLValue of type  Tuple1, the result is the serialization of the CLParse inner value in the Tuple1
+(NSString*) serializeFromCLParseTuple1:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    ret  = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed1];
    return ret;
}

///This function serialize  CLValue of type  Tuple2,  the result is the concatenation of 2 inner CLParse values in the Tuple2
+(NSString*) serializeFromCLParseTuple2:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    ret  = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed1];
    NSString * ret2 = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed2];
    ret = [NSString stringWithFormat:@"%@%@",ret,ret2];
    return ret;
}

///This function serialize  CLValue of type  Tuple3, the result is the concatenation of 3 inner CLParse values in the Tuple3
+(NSString*) serializeFromCLParseTuple3:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    ret  = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed1];
    NSString * ret2 = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed2];
    ret = [NSString stringWithFormat:@"%@%@",ret,ret2];
    ret2 = [CLParseSerializeHelper serializeFromCLParse:fromCLParse.innerParsed3];
    ret = [NSString stringWithFormat:@"%@%@",ret,ret2];
    return ret;
}
///Function for the serialization of  CLParse primitive in type with no recursive CLValue inside, such as Bool, U8, U32, I32, String, ....
+(NSString*) serializeFromCLParsePrimitive:(CLParsed*) fromCLParse {
    if ([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_BOOL]) {
        return [CLParseSerializeHelper serializeFromCLParseBool:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U8]) {
        return [CLParseSerializeHelper serializeFromCLParseU8:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U32]) {
        return [CLParseSerializeHelper serializeFromCLParseU32:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U64]) {
        return [CLParseSerializeHelper serializeFromCLParseU64:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_I32]) {
        return [CLParseSerializeHelper serializeFromCLParseInt32:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_I64]) {
        return [CLParseSerializeHelper serializeFromCLParseInt64:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U128]) {
        return [CLParseSerializeHelper serializeFromCLParseBigNumber:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U256]) {
        return [CLParseSerializeHelper serializeFromCLParseBigNumber:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_U512]) {
        return [CLParseSerializeHelper serializeFromCLParseBigNumber:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_STRING]) {
        return [CLParseSerializeHelper serializeFromCLParseString:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_UNIT]) {
        return [CLParseSerializeHelper serializeFromCLParseUnit:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_KEY]) {
        return [CLParseSerializeHelper serializeFromCLParseKey:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_UREF]) {
        return [CLParseSerializeHelper serializeFromCLParseURef:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_PUBLICKEY]) {
        return [CLParseSerializeHelper serializeFromCLParsePublicKey:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_BYTEARRAY]) {
        return [CLParseSerializeHelper serializeFromCLParseByteArray:fromCLParse];
    }  else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_ANY]) {
        return @"ANY_SERIALIZATION_NOT_COUNTED"; //CLTYPE ANY is not processed here since the value of serialization is not determined
        //Just put the result of 1 alert sentence here, in case later in the future the value can be processed
    }
    return @"NONE_PRIMITIVE";
}
///Function for the serialization of  CLParse compound in type with  recursive CLValue inside, such as Option, List, Map, Tuple1, Tuple2, Tuple3, Result
+(NSString*) serializeFromCLParseCompound:(CLParsed*) fromCLParse {
    NSString * ret = @"";
    if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_OPTION]) {
        ret = [CLParseSerializeHelper serializeFromCLParseOption:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_LIST]) {
        ret = [CLParseSerializeHelper serializeFromCLParseList:fromCLParse];
    } else if([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_MAP]) {
        ret = [CLParseSerializeHelper serializeFromCLParseMap:fromCLParse];
    } else if ([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_TUPLE1]) {
        ret = [CLParseSerializeHelper serializeFromCLParseTuple1:fromCLParse];
    } else if ([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_TUPLE2]) {
        ret = [CLParseSerializeHelper serializeFromCLParseTuple2:fromCLParse];
    } else if ([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_TUPLE3]) {
        ret = [CLParseSerializeHelper serializeFromCLParseTuple3:fromCLParse];
    } else if ([fromCLParse.itsCLType.itsType isEqualToString:CLTYPE_RESULT]) {
        ret = [CLParseSerializeHelper serializeFromCLParseResult:fromCLParse];
    }
    return ret;
}
+(NSString*) serializeFromCLParse:(CLParsed*) fromCLParse{
    NSString * ret = @"";
    if ([fromCLParse isPrimitive] == true) {
        ret = [CLParseSerializeHelper serializeFromCLParsePrimitive:fromCLParse];
    } else {
        ret = [CLParseSerializeHelper serializeFromCLParseCompound:fromCLParse];
    }
    return ret;
}

@end
