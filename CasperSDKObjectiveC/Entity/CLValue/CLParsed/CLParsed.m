#import <Foundation/Foundation.h>
#import "CLParsed.h"
#import "ConstValues.h"
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
@implementation CLParsed
///Generate the CLParse object  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsed:(NSObject*) fromObj withCLType:(CLType *)clType{
    CLParsed * ret = [[CLParsed alloc] init];
    ret.itsCLType = clType;
    if ([fromObj isEqual:[NSNull null]]) {
        ret.itsValueStr = CLTYPE_NULL_VALUE;
        return  ret;
    }
    if ([clType isCLTypePrimitive]) {
        ret = [CLParsed fromObjToCLParsedPrimitive:fromObj withCLType:clType];
    } else {
        ret = [CLParsed fromObjToCLParsedCompound:(NSDictionary*) fromObj withCLType:clType];
    }
    return ret;
}
///Generate the CLParse object  of type primitive (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsedPrimitive:(NSObject*) fromObj withCLType:(CLType *)clType{
    CLParsed * ret = [[CLParsed alloc] init];
    ret.itsValueStr = (NSString*) fromObj;
    ret.itsCLType = clType;
    return ret;
}
///Generate the CLParse object  of type compound (type with recursive CLValue inside its body, such as List, Map, Tuple , Result ,Option...)  from the JSON object fromObj with given clType
+(CLParsed*) fromObjToCLParsedCompound:(NSObject*) fromObj withCLType:(CLType *)clType{
    CLParsed * ret = [[CLParsed alloc] init];
    ret.itsCLType = clType;
    if ([clType.itsType isEqual: CLTYPE_LIST]) {
        ret.is_array_type = true;
        ret.arrayValue = [[NSMutableArray alloc] init];
        NSArray * list = (NSArray*) fromObj;
        int totalListE = (int) list.count;
        for(int i = 0 ; i < totalListE;i ++) {
            NSObject * item = (NSObject*)[list objectAtIndex:i];
            CLParsed * listInnerItem = [[CLParsed alloc] init];
            listInnerItem = [CLParsed fromObjToCLParsed:item withCLType:clType.innerType1];
            [ret.arrayValue addObject:listInnerItem];
        }
    } else if ([clType.itsType isEqual: CLTYPE_LIST_MAP_KEY]) {
       ret.is_array_type = true;
        ret.arrayValue = [[NSMutableArray alloc] init];
        NSArray * list = (NSArray*) fromObj;
        int totalListE = (int) list.count;
        for(int i = 0 ; i < totalListE;i ++) {
            NSObject * item = (NSObject*)[list objectAtIndex:i];
            CLParsed * listInnerItem = [[CLParsed alloc] init];
            listInnerItem = [CLParsed fromObjToCLParsed:item withCLType:clType.innerType1];
            [ret.arrayValue addObject:listInnerItem];
        }
    } else if ([clType.itsType isEqual: CLTYPE_LIST_MAP_VALUE]) {
        ret.is_array_type = true;
        ret.arrayValue = [[NSMutableArray alloc] init];
        NSArray * list = (NSArray*) fromObj;
        int totalListE = (int) list.count;
        for(int i = 0 ; i < totalListE;i ++) {
            NSObject * item = (NSObject*)[list objectAtIndex:i];
            CLParsed * listInnerItem = [[CLParsed alloc] init];
            listInnerItem = [CLParsed fromObjToCLParsed:item withCLType:clType.innerType1];
            [ret.arrayValue addObject:listInnerItem];
        }
    }else if ([clType.itsType isEqual: CLTYPE_MAP]) {
        ret.is_array_type = false;
        ret.is_innerParsed1_exists = true;
        ret.is_innerParsed2_exists = true;
        ret.is_innerParsed3_exists = false;
        ret.innerParsed1 = [[CLParsed alloc] init];
        ret.innerParsed2 = [[CLParsed alloc] init];
        CLType * type1 = [[CLType alloc] init];
        CLType * type2 = [[CLType alloc] init];
        type1.itsType = CLTYPE_LIST;
        type2.itsType = CLTYPE_LIST;
        type1.innerType1 = [[CLType alloc] init];
        type2.innerType1 = [[CLType alloc] init];
        type1.innerType1 = clType.innerType1;
        type2.innerType1 = clType.innerType2;
        ret.innerParsed1.itsCLType = type1;
        ret.innerParsed2.itsCLType = type2;
        ret.innerParsed1.is_array_type = true;
        ret.innerParsed2.is_array_type = true;
        ret.innerParsed1.arrayValue = [[NSMutableArray alloc] init];
        ret.innerParsed2.arrayValue = [[NSMutableArray alloc] init];
        NSArray * arrayMap = (NSArray*) fromObj;
        int totalMapValues = (int) arrayMap.count;
        for(int i = 0 ; i < totalMapValues; i ++ ) {
            NSDictionary * dict = (NSDictionary*) [arrayMap objectAtIndex:i];
            CLParsed * key = [CLParsed fromObjToCLParsed:(NSObject*) dict[@"key"] withCLType:clType.innerType1];
            CLParsed * value = [CLParsed fromObjToCLParsed:(NSObject*) dict[@"value"] withCLType:clType.innerType2];
            [ret.innerParsed1.arrayValue addObject:key];
            [ret.innerParsed2.arrayValue addObject:value];
        }
    } else if ([clType.itsType isEqual: CLTYPE_OPTION]) {
        ret.is_array_type = false;
        if([fromObj isEqual: [NSNull null]]) {
            ret.itsValueStr = CLTYPE_NULL_VALUE;
        } else {
            ret = [CLParsed fromObjToCLParsed:fromObj withCLType:clType.innerType1];
        }
    } else if ([clType.itsType isEqual: CLTYPE_RESULT]) {
        ret.is_array_type = false;
        NSDictionary * dict = [[NSDictionary alloc] init];
        dict = (NSDictionary*) fromObj;
        if (!(dict[@"Ok"] == nil)) {
            ret = [CLParsed fromObjToCLParsed:(NSObject*) dict[@"Ok"] withCLType:clType];
        } else {
            ret.itsValueStr = CLTYPE_NULL_VALUE;
        }
    } else if ([clType.itsType isEqual:CLTYPE_TUPLE1]) {
        NSArray * listParsed = (NSArray*) fromObj;
        CLParsed * parsed1 = [[CLParsed alloc] init];
        parsed1 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:0] withCLType:clType.innerType1];
        ret.innerParsed1 = [[CLParsed alloc] init];
        ret.innerParsed1 = parsed1;
        ret.is_innerParsed1_exists = true;
    } else if ([clType.itsType isEqual:CLTYPE_TUPLE2]) {
        NSArray * listParsed = (NSArray*) fromObj;
        CLParsed * parsed1 = [[CLParsed alloc] init];
        CLParsed * parsed2 = [[CLParsed alloc] init];
        parsed1 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:0] withCLType:clType.innerType1];
        parsed2 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:1] withCLType:clType.innerType2];
        ret.innerParsed1 = [[CLParsed alloc] init];
        ret.innerParsed2 = [[CLParsed alloc] init];
        ret.innerParsed1 = parsed1;
        ret.innerParsed2 = parsed2;
        ret.is_innerParsed1_exists = true;
        ret.is_innerParsed2_exists = true;
    }
    else if ([clType.itsType isEqual:CLTYPE_TUPLE3]) {
        NSArray * listParsed = (NSArray*) fromObj;
        CLParsed * parsed1 = [[CLParsed alloc] init];
        CLParsed * parsed2 = [[CLParsed alloc] init];
        CLParsed * parsed3 = [[CLParsed alloc] init];
        parsed1 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:0] withCLType:clType.innerType1];
        parsed2 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:1] withCLType:clType.innerType2];
        parsed3 = [CLParsed fromObjToCLParsed:(NSObject*) [listParsed objectAtIndex:2] withCLType:clType.innerType3];
        ret.innerParsed1 = [[CLParsed alloc] init];
        ret.innerParsed2 = [[CLParsed alloc] init];
        ret.innerParsed3 = [[CLParsed alloc] init];
        ret.innerParsed1 = parsed1;
        ret.innerParsed2 = parsed2;
        ret.innerParsed3 = parsed3;
        ret.is_innerParsed1_exists = true;
        ret.is_innerParsed2_exists = true;
        ret.is_innerParsed3_exists = true;
        
    }
    return ret;
}
///Check if the CLParse from CLType primitive, type that has no recursive CLType inside (such as bool, i32, i64, u8, u32, u64, u128, u266, u512, string, unit, publickey, key, ...)
-(bool) isPrimitive {
    if ([self.itsCLTypeStr isEqualToString:CLTYPE_BOOL]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U8]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_I32]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_I64]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U32]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U64]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_STRING]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_KEY]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_UREF]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_PUBLICKEY]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_UNIT]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U128]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U256]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_U512]) {
        return true;
    } else  if ([self.itsCLTypeStr isEqualToString:CLTYPE_BYTEARRAY]) {
        return true;
    }
    return false;
}
///Generate the CLParse object with given information of Type and value
+(CLParsed*) clParsedWithType:(NSString*) type andValue:(NSString*) value {
    CLParsed * ret = [[CLParsed alloc] init];
    ret.itsValueStr = value;
    ret.itsCLTypeStr = type;
    return ret;
}

-(void) logInfo {
    if (self.itsValueStr == CLTYPE_NULL_VALUE) {
        NSLog(@"Value of parsed:NULL");
    }
    else if (self.itsCLType.isCLTypePrimitive == true) {
        NSLog(@"Value of parsed:%@",self.itsValueStr);
    } else if (self.is_array_type == true) {
        int totalValue = (int) self.arrayValue.count;
        if (self.itsCLType.itsType == CLTYPE_LIST) {
            NSLog(@"Total element in list:%i",totalValue);
        } else if (self.itsCLType.itsType == CLTYPE_LIST_MAP_KEY) {
            NSLog(@"Total element in key list:%i",totalValue);
        } else if (self.itsCLType.itsType == CLTYPE_LIST_MAP_VALUE) {
            NSLog(@"Total element in value list:%i",totalValue);
        }
        for(int i = 0 ; i < totalValue;i ++) {
            CLParsed * oneParsed = [self.arrayValue objectAtIndex:i];
            [oneParsed logInfo];
        }
    } else {
        if(self.itsCLType.itsType == CLTYPE_LIST) {
            int totalValue = (int) self.arrayValue.count;
            NSLog(@"Total element in list:%i",totalValue);
            for(int i = 0 ; i < totalValue;i ++) {
                CLParsed * oneParsed = [self.arrayValue objectAtIndex:i];
                [oneParsed logInfo];
            }
        } else if(self.itsCLType.itsType == CLTYPE_LIST_MAP_KEY) {
            int totalValue = (int) self.arrayValue.count;
            NSLog(@"Total element in list key:%i",totalValue);
            for(int i = 0 ; i < totalValue;i ++) {
                CLParsed * oneParsed = [self.arrayValue objectAtIndex:i];
                [oneParsed logInfo];
            }
        } else if(self.itsCLType.itsType == CLTYPE_LIST_MAP_VALUE) {
            int totalValue = (int) self.arrayValue.count;
            NSLog(@"Total element in list value:%i",totalValue);
            for(int i = 0 ; i < totalValue;i ++) {
                CLParsed * oneParsed = [self.arrayValue objectAtIndex:i];
                [oneParsed logInfo];
            }
        } else if (self.itsCLType.itsType == CLTYPE_MAP) {
            NSLog(@"CLParsed Map, Key information:");
            [self.innerParsed1 logInfo];
            NSLog(@"CLParsed Map, Value information:");
            [self.innerParsed2 logInfo];
        } else if (self.itsCLType.itsType == CLTYPE_OPTION) {
            NSLog(@"Option value");
        }
    }
}
-(id)init {
    if ( self = [super init] ) {
        self.is_innerParsed1_exists = false;
        self.is_innerParsed2_exists = false;
        self.is_innerParsed3_exists = false;
        self.itsCLType = [[CLType alloc] init];
    }
    return self;
}

@end
