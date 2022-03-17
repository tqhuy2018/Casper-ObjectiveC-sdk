#import <Foundation/Foundation.h>
#import "CLType.h"
#import "ConstValues.h"
@implementation CLType
-(void) logInfo {
    NSLog(@"CLType is %@",_itsType);
    if (self.is_innerType1_exists) {
        [self.innerType1 logInfo];
    }
    if (self.is_innerType2_exists) {
        [self.innerType2 logInfo];
    }
    if (self.is_innerType3_exists) {
        [self.innerType3 logInfo];
    }
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
        NSLog(@"MapElement:%@",mapsElement);
        ret.innerType1 = [[CLType alloc] init];
        ret.innerType2 = [[CLType alloc] init];
        ret.innerType1 = [CLType fromObjToCLType: (NSObject*) mapsElement[@"key"]];
        ret.innerType2 = [CLType fromObjToCLType: (NSObject*) mapsElement[@"value"]];
        ret.is_innerType1_exists = true;
        ret.is_innerType2_exists = true;
    }else if (!(fromDict[@"Result"] == nil)) {
        ret.itsType = CLTYPE_RESULT;
        NSDictionary * resultElement = (NSDictionary*) fromDict[@"Result"];
        NSLog(@"Result Element:%@",resultElement);
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
-(NSString*) getItsType {
    NSString * ret = @"";
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
