#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/ConstValues.h>
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
@implementation CLType

///Generate the CLType object  from the JSON object fromObj
+(CLType*) fromObjToCLType:(NSObject*) fromObj {
    CLType * ret = [[CLType alloc] init];
    if([fromObj isKindOfClass:[NSString class]]) {
        //NSLog(@"cltype of primitive type:%@",(NSString*) fromObj);
        ret = [CLType fromObjToPrimitiveCLType:fromObj];
    } else  {
        ret = [CLType fromObjToCompoundCLType:(NSDictionary*) fromObj];
    }
    return ret;
}
///Generate the CLType object (of type primitive (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)  from the JSON object fromObj
+(CLType*) fromObjToCompoundCLType:(NSDictionary*) fromDict {
    CLType * ret = [[CLType alloc] init];
    if (!(fromDict[@"Option"] == nil)) {
        ret.itsType = CLTYPE_OPTION;
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType1 = [CLType fromObjToCLType:fromDict[@"Option"]];
        ret.is_innerType1_exists = true;
    } else if(!(fromDict[@"ByteArray"] == nil)) {
        ret.itsType = CLTYPE_BYTEARRAY;
    } else if(!(fromDict[@"List"] == nil)) {
        ret.itsType = @"List";
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType1 = [CLType fromObjToCLType:fromDict[@"List"]];
        ret.is_innerType1_exists = true;
    } else if (!(fromDict[@"Map"] == nil)) {
        ret.itsType = CLTYPE_MAP;
        NSDictionary * mapsElement = (NSDictionary*) fromDict[@"Map"];
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType2 = [[CLType alloc] init];
        ret.innerType1 = [CLType fromObjToCLType: (NSObject*) mapsElement[@"key"]];
        ret.innerType2 = [CLType fromObjToCLType: (NSObject*) mapsElement[@"value"]];
        ret.is_innerType1_exists = true;
        ret.is_innerType2_exists = true;
    }else if (!(fromDict[@"Result"] == nil)) {
        ret.itsType = CLTYPE_RESULT;
        NSDictionary * resultElement = (NSDictionary*) fromDict[@"Result"];
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType2 = [[CLType alloc] init];
        ret.innerType1 = [CLType fromObjToCLType: (NSObject*) resultElement[@"ok"]];
        ret.innerType2 = [CLType fromObjToCLType: (NSObject*) resultElement[@"err"]];
        ret.is_innerType1_exists = true;
        ret.is_innerType2_exists = true;
    }  else if (!(fromDict[@"Tuple1"] == nil)) {
        ret.itsType = CLTYPE_TUPLE1;
        ret.innerType1 = [[CLType alloc] init];
        NSArray * listTupleItem = (NSArray*) fromDict[@"Tuple1"];
        ret.innerType1 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:0]];
        ret.is_innerType1_exists = true;
    } else if (!(fromDict[@"Tuple2"] == nil)) {
        ret.itsType = CLTYPE_TUPLE2;
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType2 = [[CLType alloc] init];
        NSArray * listTupleItem = (NSArray*) fromDict[@"Tuple2"];
        ret.innerType1 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:0]];
        ret.innerType2 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:1]];
        ret.is_innerType1_exists = true;
        ret.is_innerType2_exists = true;
    } else if (!(fromDict[@"Tuple3"] == nil)) {
        ret.itsType = CLTYPE_TUPLE3;
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType2 = [[CLType alloc] init];
        ret.innerType3 = [[CLType alloc] init];
        NSArray * listTupleItem = (NSArray*) fromDict[@"Tuple3"];
        ret.innerType1 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:0]];
        ret.innerType2 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:1]];
        ret.innerType3 = [CLType fromObjToCLType:[listTupleItem objectAtIndex:2]];
        ret.is_innerType1_exists = true;
        ret.is_innerType2_exists = true;
        ret.is_innerType3_exists = true;
    }
    return ret;
}
///Generate the CLType object (of type primitive (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)  from the JSON object fromObj
+(CLType*) fromObjToPrimitiveCLType:(NSObject*) fromObj {
    CLType * ret = [[CLType alloc] init];
    ret.itsType = (NSString *) fromObj;
    return ret;
}
///Function to get the tag for CLType
+(NSString*) getTagForCLType:(CLType*) clType {
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
        NSString * optionTypeSerialized = [CLType getTagForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"0d%@", optionTypeSerialized];
        return retStr;
    }  else if (clType.itsType == CLTYPE_LIST) {
        NSString * listTypeSerialized = [CLType getTagForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"0e%@", listTypeSerialized];
        return retStr;
    }  else if (clType.itsType == CLTYPE_BYTEARRAY) {
        return @"0f";
    }  else if (clType.itsType == CLTYPE_RESULT) {
        NSString * result1 = [CLType getTagForCLType:clType.innerType1];
        NSString * result2 = [CLType getTagForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"10%@%@", result1,result2];
        return retStr;
    } else if (clType.itsType == CLTYPE_MAP) {
        NSString * map1 = [CLType getTagForCLType:clType.innerType1];
        NSString * map2 = [CLType getTagForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"11%@%@", map1,map2];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE1) {
        NSString * tuple1 = [CLType getTagForCLType:clType.innerType1];
        NSString * retStr = [NSString stringWithFormat:@"12%@", tuple1];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE2) {
        NSString * tuple21 = [CLType getTagForCLType:clType.innerType1];
        NSString * tuple22 = [CLType getTagForCLType:clType.innerType2];
        NSString * retStr = [NSString stringWithFormat:@"13%@%@", tuple21,tuple22];
        return retStr;
    } else if (clType.itsType == CLTYPE_TUPLE3) {
        NSString * tuple21 = [CLType getTagForCLType:clType.innerType1];
        NSString * tuple22 = [CLType getTagForCLType:clType.innerType2];
        NSString * tuple23 = [CLType getTagForCLType:clType.innerType3];
        NSString * retStr = [NSString stringWithFormat:@"14%@%@%@", tuple21,tuple22,tuple23];
        return retStr;
    } else if (clType.itsType == CLTYPE_ANY) {
        return @"15";
    } else if (clType.itsType == CLTYPE_PUBLICKEY) {
        return @"16";
    }
    return @"--00--";
}

-(NSString*) getItsType {
    NSString * ret = @"";
    if([self isCLTypePrimitive]) {
        ret = self.itsType;
    } else if (self.itsType == CLTYPE_LIST) {
        NSString * innerTypeStr = [self.innerType1 getItsType];
        ret = [[NSString alloc] initWithFormat:@"List{%@}",innerTypeStr];
    } else if (self.itsType == CLTYPE_MAP) {
        NSString * innterType1Str = [self.innerType1 getItsType];
        NSString * innterType2Str = [self.innerType2 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Map{key:%@,value:%@}",innterType1Str,innterType2Str];
    } else if (self.itsType == CLTYPE_OPTION) {
        NSString * innerType = [self.innerType1 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Option{%@}",innerType];
    } else if (self.itsType == CLTYPE_TUPLE1) {
        NSString * innerType = [self.innerType1 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Tuple1{%@}",innerType];
    } else if (self.itsType == CLTYPE_TUPLE2) {
        NSString * innerType1 = [self.innerType1 getItsType];
        NSString * innerType2 = [self.innerType2 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Tuple2{%@,%@}",innerType1,innerType2];
    } else if (self.itsType == CLTYPE_TUPLE3) {
        NSString * innerType1 = [self.innerType1 getItsType];
        NSString * innerType2 = [self.innerType2 getItsType];
        NSString * innerType3 = [self.innerType2 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Tuple3{%@,%@,%@}",innerType1,innerType2,innerType3];
    } else if (self.itsType == CLTYPE_BYTEARRAY) {
        ret = @"ByteArray";
    } else if (self.itsType == CLTYPE_RESULT) {
        NSString * innerType1 = [self.innerType1 getItsType];
        NSString * innerType2 = [self.innerType2 getItsType];
        ret = [[NSString alloc] initWithFormat:@"Result{err:%@,ok:%@}",innerType1,innerType2];
    }
    return ret;
}
///Check if the  CLType is primitive, type that has no recursive CLType inside (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)
-(bool) isCLTypePrimitive {
    if (self.itsType == CLTYPE_LIST || self.itsType == CLTYPE_MAP || self.itsType == CLTYPE_TUPLE1|| self.itsType == CLTYPE_TUPLE2|| self.itsType == CLTYPE_TUPLE3|| self.itsType == CLTYPE_OPTION|| self.itsType == CLTYPE_RESULT) {
        return false;
    }
    return  true;
}
-(id)init {
    if ( self = [super init] ) {
       
    }
    return self;
}
-(void) logInfo {
    NSString * type = [self getItsType];
    NSLog(@"CLType:%@",type);
}

/// Function to turn 1 CLType object to Json string, used for account_put_deploy RPC method call.
+(NSString *) toJsonString:(CLType *) fromCLType {
    NSString * ret = @"";
    if ([fromCLType isCLTypePrimitive]) {
        ret = [CLType fromCLTypePrimitiveToJsonString:fromCLType];
        if(fromCLType.itsType == CLTYPE_BYTEARRAY) {
            ret = [[NSString alloc] initWithFormat:@"%@",ret];
        } else {
            ret = [[NSString alloc] initWithFormat:@"\"%@\"",ret];
        }
    } else {
        ret = [CLType fromCLTypeCompoundToJsonString:fromCLType];
    }
    return  ret;
}

/// Function to turn 1 CLType object of type compound to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with recursive CLType inside its body, such as List, Option, Tuple1, Tuple2, Tuple3, Result, Map.
+(NSString *) fromCLTypeCompoundToJsonString:(CLType *) fromCLType {
    NSString * ret = @"";
    if (fromCLType.itsType == CLTYPE_BYTEARRAY) {
        return @"{\"ByteArray\": 32}";
    } else if (fromCLType.itsType == CLTYPE_LIST) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"List\": \"%@\"}",innerType1String];
            return ret;
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"List\": %@}",innerType1String];
            return ret;
        }
    } else if (fromCLType.itsType == CLTYPE_OPTION) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"Option\": \"%@\"}",innerType1String];
            return ret;
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"Option\": %@}",innerType1String];
            return ret;
        }
    } else if (fromCLType.itsType == CLTYPE_RESULT) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Result\": {\"ok\": %@, \"err\": %@}}",innerType1String,innerType2String];
                return ret;
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Result\": {\"ok\": %@, \"err\": %@}}",innerType1String,innerType2String];
            }
            return ret;
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Result\": {\"ok\": %@, \"err\": %@}}",innerType1String,innerType2String];
                return ret;
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Result\": {\"ok\": %@, \"err\": %@}}",innerType1String,innerType2String];
            }
            return ret;
        }
    } else if (fromCLType.itsType == CLTYPE_MAP) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                NSString * keyValueString = [[NSString alloc] initWithFormat:@"{\"key\": \"%@\", \"value\": \"%@\"}",innerType1String,innerType2String];
                ret = [[NSString alloc] initWithFormat:@"{\"Map\": %@}",keyValueString];
                return ret;
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                NSString * keyValueString = [[NSString alloc] initWithFormat:@"{\"key\": \"%@\", \"value\": %@}",innerType1String,innerType2String];
                ret = [[NSString alloc] initWithFormat:@"{\"Map\": %@}",keyValueString];
            }
            return ret;
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                NSString * keyValueString = [[NSString alloc] initWithFormat:@"{\"key\": %@, \"value\": \"%@\"}",innerType1String,innerType2String];
                ret = [[NSString alloc] initWithFormat:@"{\"Map\": %@}",keyValueString];
                return ret;
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                NSString * keyValueString = [[NSString alloc] initWithFormat:@"{\"key\": %@, \"value\": %@}",innerType1String,innerType2String];
                ret = [[NSString alloc] initWithFormat:@"{\"Map\": %@}",keyValueString];
            }
        }
    }  else if (fromCLType.itsType == CLTYPE_TUPLE1) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"Tuple1\": \"%@\"}",innerType1String];
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"{\"Tuple1\": %@}",innerType1String];
        }
    } else if (fromCLType.itsType == CLTYPE_TUPLE2) {
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Tuple2\": [\"%@\", \"%@\"]}",innerType1String,innerType2String];
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Tuple2\": [\"%@\", %@]}",innerType1String,innerType2String];
            }
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            if ([fromCLType.innerType2 isCLTypePrimitive]) {
                NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Tuple2\": [%@, \"%@\"]}",innerType1String,innerType2String];
            } else {
                NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
                ret = [[NSString alloc] initWithFormat:@"{\"Tuple2\": [%@, %@]}",innerType1String,innerType2String];
            }
        }
    } else if (fromCLType.itsType == CLTYPE_TUPLE3) {
        ret = @"{\"Tuple3\": [";
        if ([fromCLType.innerType1 isCLTypePrimitive]) {
            NSString * innerType1String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"%@\"%@\",",ret,innerType1String];
        } else {
            NSString * innerType1String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType1];
            ret = [[NSString alloc] initWithFormat:@"%@%@,",ret,innerType1String];
        }
        if ([fromCLType.innerType2 isCLTypePrimitive]) {
            NSString * innerType2String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType2];
            ret = [[NSString alloc] initWithFormat:@"%@\"%@\",",ret,innerType2String];
        } else {
            NSString * innerType2String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType2];
            ret = [[NSString alloc] initWithFormat:@"%@%@,",ret,innerType2String];
        }
        if ([fromCLType.innerType3 isCLTypePrimitive]) {
            NSString * innerType3String = [CLType fromCLTypePrimitiveToJsonString:fromCLType.innerType3];
            ret = [[NSString alloc] initWithFormat:@"%@\"%@\"]",ret,innerType3String];
        } else {
            NSString * innerType3String = [CLType fromCLTypeCompoundToJsonString:fromCLType.innerType3];
            ret = [[NSString alloc] initWithFormat:@"%@%@]",ret,innerType3String];
        }
    }
    return ret;
}

/// Function to turn 1 CLType object of type primitive to Json string, used for account_put_deploy RPC method call.
/// CLType of type compound is of type with no recursive CLType inside its body, such as Bool, U8, I32, I64, U32, U64, U128....
+(NSString *) fromCLTypePrimitiveToJsonString:(CLType *) fromCLType {
    if (fromCLType.itsType == CLTYPE_BOOL) {
        return @"Bool";
    } else if (fromCLType.itsType == CLTYPE_U8) {
        return @"U8";
    } else if (fromCLType.itsType == CLTYPE_I32) {
        return @"I32";
    } else if (fromCLType.itsType == CLTYPE_I64) {
        return @"I64";
    } else if (fromCLType.itsType == CLTYPE_U32) {
        return @"U32";
    } else if (fromCLType.itsType == CLTYPE_U64) {
        return @"U64";
    } else if (fromCLType.itsType == CLTYPE_U128) {
        return @"U128";
    } else if (fromCLType.itsType == CLTYPE_U256) {
        return @"U256";
    } else if (fromCLType.itsType == CLTYPE_U512) {
        return @"U512";
    } else if (fromCLType.itsType == CLTYPE_UNIT) {
        return @"Unit";
    } else if (fromCLType.itsType == CLTYPE_STRING) {
        return @"String";
    } else if (fromCLType.itsType == CLTYPE_KEY) {
        return @"Key";
    } else if (fromCLType.itsType == CLTYPE_UREF) {
        return @"URef";
    } else if (fromCLType.itsType == CLTYPE_PUBLICKEY) {
        return @"PublicKey";
    } else if (fromCLType.itsType == CLTYPE_ANY) {
        return @"Any";
    } else if (fromCLType.itsType == CLTYPE_BYTEARRAY) {
        return @"{\"ByteArray\": 32}";
    }
    return @"NONE";
}
@end
