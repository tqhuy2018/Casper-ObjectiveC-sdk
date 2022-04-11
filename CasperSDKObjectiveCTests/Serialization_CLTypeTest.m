
#import <XCTest/XCTest.h>
#import "CLType.h"
#import "CLTypeSerializeHelper.h"
#import "ConstValues.h"
@interface Serialization_CLTypeTest : XCTestCase

@end

@implementation Serialization_CLTypeTest

- (void) testCLTypeSerialization {
    CLType * typeBool = [[CLType alloc] init];
    typeBool.itsType = CLTYPE_BOOL;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeBool] isEqualToString:@"00"]);
    
    CLType * typeI32 = [[CLType alloc] init];
    typeI32.itsType = CLTYPE_I32;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeI32] isEqualToString:@"01"]);

    CLType * typeI64 = [[CLType alloc] init];
    typeI64.itsType = CLTYPE_I64;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeI64] isEqualToString:@"02"]);
    
    CLType * typeU8 = [[CLType alloc] init];
    typeU8.itsType = CLTYPE_U8;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU8] isEqualToString:@"03"]);
    
    CLType * typeU32 = [[CLType alloc] init];
    typeU32.itsType = CLTYPE_U32;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU32] isEqualToString:@"04"]);
    
    CLType * typeU64 = [[CLType alloc] init];
    typeU64.itsType = CLTYPE_U64;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU64] isEqualToString:@"05"]);

    CLType * typeU128 = [[CLType alloc] init];
    typeU128.itsType = CLTYPE_U128;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU128] isEqualToString:@"06"]);
    
    CLType * typeU256 = [[CLType alloc] init];
    typeU256.itsType = CLTYPE_U256;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU256] isEqualToString:@"07"]);
    
    CLType * typeU512 = [[CLType alloc] init];
    typeU512.itsType = CLTYPE_U512;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeU512] isEqualToString:@"08"]);

    CLType * typeUnit = [[CLType alloc] init];
    typeUnit.itsType = CLTYPE_UNIT;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeUnit] isEqualToString:@"09"]);
    
    CLType * typeString = [[CLType alloc] init];
    typeString.itsType = CLTYPE_STRING;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeString] isEqualToString:@"0a"]);
    
    CLType * typeKey = [[CLType alloc] init];
    typeKey.itsType = CLTYPE_KEY;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeKey] isEqualToString:@"0b"]);
    
    CLType * typeURef = [[CLType alloc] init];
    typeURef.itsType = CLTYPE_UREF;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeURef] isEqualToString:@"0c"]);
    
    //Test for CLType Option
    CLType * typeOption = [[CLType alloc] init];
    typeOption.itsType = CLTYPE_OPTION;
    NSString * optionTypeSerialized = [CLTypeSerializeHelper serializeForCLType:typeOption.innerType1];
    NSString * retStr = [NSString stringWithFormat:@"0d%@", optionTypeSerialized];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeOption] isEqualToString:retStr]);
    
    //Test for CLType List
    CLType * typeList = [[CLType alloc] init];
    typeList.itsType = CLTYPE_LIST;
    NSString * listInnerTypeSerialized = [CLTypeSerializeHelper serializeForCLType:typeList.innerType1];
    NSString * listSerialize = [NSString stringWithFormat:@"0e%@", listInnerTypeSerialized];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeList] isEqualToString:listSerialize]);

    //Test for CLType Result
    CLType * typeResult = [[CLType alloc] init];
    typeResult.itsType = CLTYPE_RESULT;
    NSString * result1 = [CLTypeSerializeHelper serializeForCLType:typeResult.innerType1];
    NSString * result2 = [CLTypeSerializeHelper serializeForCLType:typeResult.innerType2];
    NSString * resultSerialize = [NSString stringWithFormat:@"10%@%@", result1,result2];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeResult] isEqualToString:resultSerialize]);
    
    //Test for CLType Map
    CLType * typeMap = [[CLType alloc] init];
    typeMap.itsType = CLTYPE_MAP;
    NSString * map1 = [CLTypeSerializeHelper serializeForCLType:typeMap.innerType1];
    NSString * map2 = [CLTypeSerializeHelper serializeForCLType:typeMap.innerType2];
    NSString * mapSerialize = [NSString stringWithFormat:@"11%@%@", map1,map2];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeMap] isEqualToString:mapSerialize]);

    //Test for CLType Tuple1
    CLType * typeTuple1 = [[CLType alloc] init];
    typeTuple1.itsType = CLTYPE_TUPLE1;
    NSString * tuple1 = [CLTypeSerializeHelper serializeForCLType:typeTuple1.innerType1];
    NSString * typeTuple1Serialize = [NSString stringWithFormat:@"12%@", tuple1];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeTuple1] isEqualToString:typeTuple1Serialize]);
    
    //Test for CLType Tuple2
    CLType * typeTuple2 = [[CLType alloc] init];
    typeTuple2.itsType = CLTYPE_TUPLE2;
    NSString * tuple21 = [CLTypeSerializeHelper serializeForCLType:typeTuple2.innerType1];
    NSString * tuple22 = [CLTypeSerializeHelper serializeForCLType:typeTuple2.innerType2];
    NSString * typeTuple2Serialize = [NSString stringWithFormat:@"13%@%@", tuple21,tuple22];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeTuple2] isEqualToString:typeTuple2Serialize]);
    
    //Test for CLType Tuple3
    CLType * typeTuple3 = [[CLType alloc] init];
    typeTuple3.itsType = CLTYPE_TUPLE3;
    NSString * tuple31 = [CLTypeSerializeHelper serializeForCLType:typeTuple3.innerType1];
    NSString * tuple32 = [CLTypeSerializeHelper serializeForCLType:typeTuple3.innerType2];
    NSString * tuple33 = [CLTypeSerializeHelper serializeForCLType:typeTuple3.innerType3];
    NSString * typeTuple3Serialize = [NSString stringWithFormat:@"14%@%@%@", tuple31,tuple32,tuple33];
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeTuple3] isEqualToString:typeTuple3Serialize]);

    CLType * typeAny = [[CLType alloc] init];
    typeAny.itsType = CLTYPE_ANY;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typeAny] isEqualToString:@"15"]);

    CLType * typePublicKey = [[CLType alloc] init];
    typePublicKey.itsType = CLTYPE_PUBLICKEY;
    XCTAssert([[CLTypeSerializeHelper serializeForCLType:typePublicKey] isEqualToString:@"16"]);
}
@end
