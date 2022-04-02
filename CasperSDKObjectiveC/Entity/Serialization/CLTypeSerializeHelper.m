#import <Foundation/Foundation.h>
#import "CLTypeSerializeHelper.h"
#import "ConstValues.h"
@implementation CLTypeSerializeHelper
+(NSString *) serializeForCLType:(CLType*) clType {
    if (clType.itsType == CLTYPE_BOOL) {
        return @"00";
    } else if (clType.itsType == CLTYPE_I32) {
        return @"01";
    } else if (clType.itsType == CLTYPE_I64) {
        return @"02";
    } else if (clType.itsType == CLTYPE_U8) {
        return @"03";
    } else if (clType.itsType == CLTYPE_U32) {
        return @"04";
    } else if (clType.itsType == CLTYPE_U64) {
        return @"05";
    } else if (clType.itsType == CLTYPE_U128) {
        return @"06";
    } else if (clType.itsType == CLTYPE_U256) {
        return @"07";
    }  else if (clType.itsType == CLTYPE_U512) {
        return @"08";
    }  else if (clType.itsType == CLTYPE_UNIT) {
        return @"09";
    }  else if (clType.itsType == CLTYPE_STRING) {
        return @"0a";
    }  else if (clType.itsType == CLTYPE_KEY) {
        return @"0b";
    }  else if (clType.itsType == CLTYPE_UREF) {
        return @"0c";
    }  else if (clType.itsType == CLTYPE_OPTION) {
        NSString * optionTypeSerialized = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"0d%@", optionTypeSerialized];
        return retStr;
    }  else if (clType.itsType == CLTYPE_LIST) {
        NSString * listTypeSerialized = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"0e%@", listTypeSerialized];
        return retStr;
    }  else if (clType.itsType == CLTYPE_BYTEARRAY) {
        return @"0f";
    }  else if (clType.itsType == CLTYPE_RESULT) {
        NSString * result1 = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * result2 = [CLTypeSerializeHelper serializeForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"10%@%@", result1,result2];
        return retStr;
    } else if (clType.itsType == CLTYPE_MAP) {
        NSString * map1 = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * map2 = [CLTypeSerializeHelper serializeForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"11%@%@", map1,map2];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE1) {
        NSString * tuple1 = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"12%@", tuple1];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE2) {
        NSString * tuple21 = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * tuple22 = [CLTypeSerializeHelper serializeForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"13%@%@", tuple21,tuple22];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE3) {
        NSString * tuple21 = [CLTypeSerializeHelper serializeForCLType:clType.innerType1];
        NSString * tuple22 = [CLTypeSerializeHelper serializeForCLType:clType.innerType2];
        NSString * tuple23 = [CLTypeSerializeHelper serializeForCLType:clType.innerType3];
        NSString * retStr = [NSString stringWithFormat:@"14%@%@%@", tuple21,tuple22,tuple23];
        return retStr;
    } else if (clType.itsType == CLTYPE_ANY) {
        return @"15";
    } else if (clType.itsType == CLTYPE_PUBLICKEY) {
        return @"16";
    }
    return @"--00--";
}
@end
