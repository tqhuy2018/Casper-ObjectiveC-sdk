#import <Foundation/Foundation.h>
#import "CLType.h"
#import "ConstValues.h"
@implementation CLType
-(void) logInfo {
    NSString * type = [self getItsType];
    NSLog(@"CLType:%@",type);
    return;
}
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
+(CLType*) fromObjToPrimitiveCLType:(NSObject*) fromObj {
    CLType * ret = [[CLType alloc] init];
    ret.itsType = (NSString *) fromObj;
    return ret;
}
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

@end
