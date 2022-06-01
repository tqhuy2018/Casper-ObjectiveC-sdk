#import <XCTest/XCTest.h>
#import <CasperSDKObjectiveC/NumberSerialize.h>
#import <CasperSDKObjectiveC/QuotientNRemainder.h>
#import <CasperSDKObjectiveC/CLParseSerializeHelper.h>
#import <CasperSDKObjectiveC/CLParsed.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/CLValue.h>
@interface Serialization_CLValueTest : XCTestCase

@end

@implementation Serialization_CLValueTest

- (void) testCLValueSerialization {
    //Test for CLValue Bool serialization
    CLParsed * parseBool = [[CLParsed alloc] init];
    parseBool.itsValueStr = @"true";
    NSString * boolSerializedTrue = [CLParseSerializeHelper serializeFromCLParseBool:parseBool];
    XCTAssert([boolSerializedTrue isEqualToString:@"01"]);
    parseBool.itsValueStr = @"false";
    NSString * boolSerializedFalse = [CLParseSerializeHelper serializeFromCLParseBool:parseBool];
    XCTAssert([boolSerializedFalse isEqualToString:@"00"]);

    //Test for CLValue u8 serialization
    CLParsed * parseU8 = [[CLParsed alloc] init];
    parseU8.itsValueStr = @"0";
    NSString * retu81 = [CLParseSerializeHelper serializeFromCLParseU8:parseU8];
    XCTAssert([retu81 isEqualToString:@"00"]);
    parseU8.itsValueStr = @"9";
    NSString * retu82 = [CLParseSerializeHelper serializeFromCLParseU8:parseU8];
    XCTAssert([retu82 isEqualToString:@"09"]);
    parseU8.itsValueStr = @"219";
    NSString * retu83 = [CLParseSerializeHelper serializeFromCLParseU8:parseU8];
    XCTAssert([retu83 isEqualToString:@"db"]);
    parseU8.itsValueStr = @"255";
    NSString * retu84 = [CLParseSerializeHelper serializeFromCLParseU8:parseU8];
    XCTAssert([retu84 isEqualToString:@"ff"]);
    
    //Test for CLValue u32 serialization
    CLParsed * parseU32 = [[CLParsed alloc] init];
    parseU32.itsValueStr = @"0";
    NSString * retU32_1 = [CLParseSerializeHelper serializeFromCLParseU32:parseU32];
    XCTAssert([retU32_1 isEqualToString:@"00000000"]);
    
    parseU32.itsValueStr = @"1024";
    NSString * retU32_2 = [CLParseSerializeHelper serializeFromCLParseU32:parseU32];
    XCTAssert([retU32_2 isEqualToString:@"00040000"]);
    
    parseU32.itsValueStr = @"7";
    NSString * retU32_3 = [CLParseSerializeHelper serializeFromCLParseU32:parseU32];
    XCTAssert([retU32_3 isEqualToString:@"07000000"]);
    
    parseU32.itsValueStr = @"5531024";
    NSString * retU32_4 = [CLParseSerializeHelper serializeFromCLParseU32:parseU32];
    XCTAssert([retU32_4 isEqualToString:@"90655400"]);
    
    //Test for CLValue u64 serialization
    
    CLParsed * parseU64 = [[CLParsed alloc] init];
    parseU64.itsValueStr = @"0";
    NSString * retU64_1 = [CLParseSerializeHelper serializeFromCLParseU64:parseU64];
    XCTAssert([retU64_1 isEqualToString:@"0000000000000000"]);
    
    parseU64.itsValueStr = @"1024";
    NSString * retU64_2 = [CLParseSerializeHelper serializeFromCLParseU64:parseU64];
    XCTAssert([retU64_2 isEqualToString:@"0004000000000000"]);

    parseU64.itsValueStr = @"33009900995531024";
    NSString * retU64_3 = [CLParseSerializeHelper serializeFromCLParseU64:parseU64];
    XCTAssert([retU64_3 isEqualToString:@"10d1e87e54467500"]);
    
    parseU64.itsValueStr = @"255";
    NSString * retU64_4 = [CLParseSerializeHelper serializeFromCLParseU64:parseU64];
    XCTAssert([retU64_4 isEqualToString:@"ff00000000000000"]);
   
    //Test for CLValue u128 serialization
    CLParsed * parseU128 = [[CLParsed alloc] init];
    
    parseU128.itsValueStr = @"999988887777666655556666777888999";
    NSString * retU128_1 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU128];
    XCTAssert([retU128_1 isEqualToString:@"0ee76837d2ca215879f7bc5ca24d31"]);
    
    parseU128.itsValueStr = @"0";
    NSString * retU128_2 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU128];
    XCTAssert([retU128_2 isEqualToString:@"00"]);
    
    parseU128.itsValueStr = @"2048";
    NSString * retU128_3 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU128];
    XCTAssert([retU128_3 isEqualToString:@"020008"]);
    
    
    //Test for CLValue u256 serialization
    CLParsed * parseU256 = [[CLParsed alloc] init];
    
    parseU256.itsValueStr = @"123456789101112131415";
    NSString * retU256_1 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU256];
    XCTAssert([retU256_1 isEqualToString:@"0957ff1ada959f4eb106"]);
   
    parseU256.itsValueStr = @"0";
    NSString * retU256_2 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU256];
    XCTAssert([retU256_2 isEqualToString:@"00"]);
    
    parseU256.itsValueStr = @"1024";
    NSString * retU256_3 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU256];
    XCTAssert([retU256_3 isEqualToString:@"020004"]);
    
    //Test for CLValue u512 serialization
    CLParsed * parseU512 = [[CLParsed alloc] init];
    
    parseU512.itsValueStr = @"0";
    NSString * retU512_1 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU512];
    XCTAssert([retU512_1 isEqualToString:@"00"]);
    
    parseU512.itsValueStr = @"4096";
    NSString * retU512_2 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU512];
    XCTAssert([retU512_2 isEqualToString:@"020010"]);
    
    parseU512.itsValueStr = @"100000000";
    NSString * retU512_3 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU512];
    XCTAssert([retU512_3 isEqualToString:@"0400e1f505"]);
    
    parseU512.itsValueStr = @"999888666555444999887988887777666655556666777888999666999";
    NSString * retU512_4 = [CLParseSerializeHelper serializeFromCLParseBigNumber:parseU512];
    XCTAssert([retU512_4 isEqualToString:@"1837f578fca55492f299ea354eaca52b6e9de47d592453c728"]);
    
   //Test for CLValue Int32 serialization
    
    CLParsed * parseI32 = [[CLParsed alloc] init];
    parseI32.itsValueStr = @"-1024";
    NSString * retI32_1 = [CLParseSerializeHelper serializeFromCLParseInt32:parseI32];
    XCTAssert([retI32_1 isEqualToString:@"00fcffff"]);
    
    parseI32.itsValueStr = @"-3333";
    NSString * retI32_2 = [CLParseSerializeHelper serializeFromCLParseInt32:parseI32];
    XCTAssert([retI32_2 isEqualToString:@"fbf2ffff"]);
    
    parseI32.itsValueStr = @"1000";
    NSString * retI32_3 = [CLParseSerializeHelper serializeFromCLParseInt32:parseI32];
    XCTAssert([retI32_3 isEqualToString:@"e8030000"]);
    
    parseI32.itsValueStr = @"0";
    NSString * retI32_4 = [CLParseSerializeHelper serializeFromCLParseInt32:parseI32];
    XCTAssert([retI32_4 isEqualToString:@"00000000"]);
    
    //Test for CLValue Int64 serialization
     
     CLParsed * parseI64 = [[CLParsed alloc] init];
    
     parseI64.itsValueStr = @"-1024";
     NSString * retI64_1 = [CLParseSerializeHelper serializeFromCLParseInt64:parseI64];
     XCTAssert([retI64_1 isEqualToString:@"00fcffffffffffff"]);

    parseI64.itsValueStr = @"1000";
    NSString * retI64_2 = [CLParseSerializeHelper serializeFromCLParseInt64:parseI64];
    XCTAssert([retI64_2 isEqualToString:@"e803000000000000"]);
    
    parseI64.itsValueStr = @"0";
    NSString * retI64_3 = [CLParseSerializeHelper serializeFromCLParseInt64:parseI64];
    XCTAssert([retI64_3 isEqualToString:@"0000000000000000"]);

    parseI64.itsValueStr = @"-123456789";
    NSString * retI64_4 = [CLParseSerializeHelper serializeFromCLParseInt64:parseI64];
    XCTAssert([retI64_4 isEqualToString:@"eb32a4f8ffffffff"]);
   
    //Test for CLValue String serialization
    
    CLParsed * parseString = [[CLParsed alloc] init];
    parseString.itsValueStr = @"Hello, World!";
    NSString * retString1 = [CLParseSerializeHelper serializeFromCLParseString:parseString];
    XCTAssert([retString1 isEqualToString:@"0d00000048656c6c6f2c20576f726c6421"]);
    
    parseString.itsValueStr = @"lWJWKdZUEudSakJzw1tn";
    NSString * retString2 = [CLParseSerializeHelper serializeFromCLParseString:parseString];
    XCTAssert([retString2 isEqualToString:@"140000006c574a574b645a5545756453616b4a7a7731746e"]);
    
    parseString.itsValueStr = @"S1cXRT3E1jyFlWBAIVQ8";
    NSString * retString3 = [CLParseSerializeHelper serializeFromCLParseString:parseString];
    XCTAssert([retString3 isEqualToString:@"140000005331635852543345316a79466c57424149565138"]);

    parseString.itsValueStr = @"123456789123456789123456789123456789123456789123456789";
    NSString * retString4 = [CLParseSerializeHelper serializeFromCLParseString:parseString];
    XCTAssert([retString4 isEqualToString:@"36000000313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839313233343536373839"]);
    
    //Test for CLValue Unit serialization
    
    CLParsed * parseUnit = [[CLParsed alloc] init];
    parseUnit.itsCLType = [[CLType alloc] init];
    parseUnit.itsCLType.itsType = CLTYPE_UNIT;
    NSString * retUnit = [CLParseSerializeHelper serializeFromCLParseUnit:parseUnit];
    XCTAssert([retUnit isEqualToString:@""]);
    
    //Test for CLValue Key serialization
    
    CLParsed * parseKey = [[CLParsed alloc] init];
    parseKey.itsValueStr = @"account-hash-d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269";
    NSString * retKey1 = [CLParseSerializeHelper serializeFromCLParseKey:parseKey];
    XCTAssert([retKey1 isEqualToString:@"00d0bc9cA1353597c4004B8F881b397a89c1779004F5E547e04b57c2e7967c6269"]);
    
    
    parseKey.itsValueStr = @"hash-8cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401";
    NSString * retKey2 = [CLParseSerializeHelper serializeFromCLParseKey:parseKey];
    XCTAssert([retKey2 isEqualToString:@"018cf5e4acf51f54eb59291599187838dc3bc234089c46fc6ca8ad17e762ae4401"]);
    
    parseKey.itsValueStr = @"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
    NSString * retKey3 = [CLParseSerializeHelper serializeFromCLParseKey:parseKey];
    XCTAssert([retKey3 isEqualToString:@"02be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607"]);
    
    //Test for CLValue URef serialization
    CLParsed * parseURef = [[CLParsed alloc] init];
    parseURef.itsValueStr = @"uref-be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c6-007";
    NSString * retURef = [CLParseSerializeHelper serializeFromCLParseURef:parseURef];
    XCTAssert([retURef isEqualToString:@"be1dc0fd639a3255c1e3e5e2aa699df66171e40fa9450688c5d718b470e057c607"]);
    
    //Test for CLValue PublicKey serialization
    CLParsed * parsePublicKey = [[CLParsed alloc] init];
    parsePublicKey.itsValueStr = @"01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b";
    NSString * retPublicKey = [CLParseSerializeHelper serializeFromCLParsePublicKey:parsePublicKey];
    XCTAssert([retPublicKey isEqualToString:@"01394476bd8202887ac0e42ae9d8f96d7e02d81cc204533506f1fd199e95b1fd2b"]);
    
    //Test for CLValue Option serialization
    CLParsed * parseOption = [[CLParsed alloc] init];
    parseOption.itsCLType = [[CLType alloc] init];
    parseOption.itsCLType.itsType = CLTYPE_OPTION;
    
    //Option(U32)
    CLParsed * parseU32InOption = [[CLParsed alloc] init];
    parseU32InOption.itsCLType = [[CLType alloc] init];
    parseU32InOption.itsCLType.itsType = CLTYPE_U32;
    parseU32InOption.itsValueStr = @"10";
    parseOption.innerParsed1 = parseU32InOption;
    NSString * parseOptionU32Serialized = [CLParseSerializeHelper serializeFromCLParseOption:parseOption];
    XCTAssert([parseOptionU32Serialized isEqualToString:@"010a000000"]);
    //Option(U64)
    CLParsed * parseU64InOption = [[CLParsed alloc] init];
    parseU64InOption.itsValueStr = @"123456";
    parseU64InOption.itsCLType = [[CLType alloc] init];
    parseU64InOption.itsCLType.itsType = CLTYPE_U64;
    parseOption.innerParsed1 = parseU64InOption;
    NSString * parseOptionU64Serialized = [CLParseSerializeHelper serializeFromCLParseOption:parseOption];
    XCTAssert([parseOptionU64Serialized isEqualToString:@"0140e2010000000000"]);

    //Option(String)
    CLParsed * parseStringInOption = [[CLParsed alloc] init];
    parseStringInOption.itsValueStr = @"Hello, World!";
    parseStringInOption.itsCLType = [[CLType alloc] init];
    parseStringInOption.itsCLType.itsType = CLTYPE_STRING;
    parseOption.innerParsed1 = parseStringInOption;
    NSString * parseOptionStringSerialized = [CLParseSerializeHelper serializeFromCLParseOption:parseOption];
    XCTAssert([parseOptionStringSerialized isEqualToString:@"010d00000048656c6c6f2c20576f726c6421"]);
    
    //Test for CLValue List serialization
    
    CLParsed * parseList = [[CLParsed alloc] init];
    parseList.itsCLType = [[CLType alloc] init];
    parseList.itsCLType.itsType = CLTYPE_LIST;
    parseList.arrayValue = [[NSMutableArray alloc] init];
    
    //List U8
    CLParsed * u81 = [[CLParsed alloc] init];
    u81.itsCLType = [[CLType alloc] init];
    u81.itsCLType.itsType = CLTYPE_U8;
    u81.itsValueStr = @"100";

    CLParsed * u82 = [[CLParsed alloc] init];
    u82.itsCLType = [[CLType alloc] init];
    u82.itsCLType.itsType = CLTYPE_U8;
    u82.itsValueStr = @"0";
    
    CLParsed * u83 = [[CLParsed alloc] init];
    u83.itsCLType = [[CLType alloc] init];
    u83.itsCLType.itsType = CLTYPE_U8;
    u83.itsValueStr = @"255";
    
    [parseList.arrayValue addObject:u81];
    [parseList.arrayValue addObject:u82];
    [parseList.arrayValue addObject:u83];
    NSString * list1Serialized = [CLParseSerializeHelper serializeFromCLParse:parseList];
    XCTAssert([list1Serialized isEqualToString:@"030000006400ff"]);
    
    //List U32
    CLParsed * u321 = [[CLParsed alloc] init];
    u321.itsCLType = [[CLType alloc] init];
    u321.itsCLType.itsType = CLTYPE_U32;
    u321.itsValueStr = @"1";

    CLParsed * u322 = [[CLParsed alloc] init];
    u322.itsCLType = [[CLType alloc] init];
    u322.itsCLType.itsType = CLTYPE_U32;
    u322.itsValueStr = @"2";
    
    CLParsed * u323 = [[CLParsed alloc] init];
    u323.itsCLType = [[CLType alloc] init];
    u323.itsCLType.itsType = CLTYPE_U32;
    u323.itsValueStr = @"3";
    
    [parseList.arrayValue removeAllObjects];
    [parseList.arrayValue addObject:u321];
    [parseList.arrayValue addObject:u322];
    [parseList.arrayValue addObject:u323];
    NSString * list2Serialized = [CLParseSerializeHelper serializeFromCLParse:parseList];
    XCTAssert([list2Serialized isEqualToString:@"03000000010000000200000003000000"]);
    
    //List String
    CLParsed * string1 = [[CLParsed alloc] init];
    string1.itsCLType = [[CLType alloc] init];
    string1.itsCLType.itsType = CLTYPE_STRING;
    string1.itsValueStr = @"Hello, World!";

    CLParsed * string2 = [[CLParsed alloc] init];
    string2.itsCLType = [[CLType alloc] init];
    string2.itsCLType.itsType = CLTYPE_STRING;
    string2.itsValueStr = @"Bonjour le monde";
    
    CLParsed * string3 = [[CLParsed alloc] init];
    string3.itsCLType = [[CLType alloc] init];
    string3.itsCLType.itsType = CLTYPE_STRING;
    string3.itsValueStr = @"Hola Mundo";
    
    [parseList.arrayValue removeAllObjects];
    [parseList.arrayValue addObject:string1];
    [parseList.arrayValue addObject:string2];
    [parseList.arrayValue addObject:string3];
    NSString * list3Serialized = [CLParseSerializeHelper serializeFromCLParse:parseList];
    XCTAssert([list3Serialized isEqualToString:@"030000000d00000048656c6c6f2c20576f726c642110000000426f6e6a6f7572206c65206d6f6e64650a000000486f6c61204d756e646f"]);
    
    //List(Map(String,String)
    //base on the deploy at this address: https://testnet.cspr.live/deploy/AaB4aa0C14a37Bc9386020609aa1CabaD895c3E2E104d877B936C6Ffa2302268
    //refer to session section of the deploy, args item number 2
    
    CLParsed * parseMapInList = [[CLParsed alloc] init];
    parseMapInList.itsCLType = [[CLType alloc] init];
    parseMapInList.itsCLType.itsType = CLTYPE_MAP;
    //Key generation
    CLParsed * parseMapInListKey = [[CLParsed alloc] init];
    parseMapInListKey.itsCLType = [[CLType alloc] init];
    parseMapInListKey.itsCLType.itsType = CLTYPE_LIST_MAP_KEY;//This assignment could drop
    parseMapInListKey.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapListKey1 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"token_uri"];
    [parseMapInListKey.arrayValue addObject:mapListKey1];
    //Value generation
    CLParsed * parseMapInListValue = [[CLParsed alloc] init];
    parseMapInListValue.itsCLType = [[CLType alloc] init];
    parseMapInListValue.itsCLType.itsType = CLTYPE_LIST_MAP_VALUE;//This assignment could drop
    parseMapInListValue.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapListValue1 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"https://gateway.pinata.cloud/ipfs/QmZNz3zVNyV383fn1ZgbroxCLSxVnx7jrq4yjGyFJoZ5Vk"];
    [parseMapInListValue.arrayValue addObject:mapListValue1];
    parseMapInList.innerParsed1 = parseMapInListKey;
    parseMapInList.innerParsed2 = parseMapInListValue;
    [parseList.arrayValue removeAllObjects];
    [parseList.arrayValue addObject:parseMapInList];
    NSString * list4Serialized = [CLParseSerializeHelper serializeFromCLParse:parseList];
    XCTAssert([list4Serialized isEqualToString:@"010000000100000009000000746f6b656e5f7572695000000068747470733a2f2f676174657761792e70696e6174612e636c6f75642f697066732f516d5a4e7a337a564e7956333833666e315a6762726f78434c5378566e78376a727134796a4779464a6f5a35566b"]);
    
    //Test for CLValue Map serialization
    CLParsed * parseMap = [[CLParsed alloc] init];
    parseMap.itsCLType = [[CLType alloc] init];
    parseMap.itsCLType.itsType = CLTYPE_MAP;
    
    //Map(String,String)
    //Test based on the deploy at this address
//https://testnet.cspr.live/deploy/430df377ae04726de907f115bb06c52e40f6cd716b4b475a10e4cd9226d1317e
    //please refer to execution_results item 86 to see the real data
    //Key generation
    CLParsed * parseMapKey = [[CLParsed alloc] init];
    parseMapKey.itsCLType = [[CLType alloc] init];
    parseMapKey.itsCLType.itsType = CLTYPE_LIST_MAP_KEY;//This assignment could drop
    parseMapKey.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapKey1 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"contract_package_hash"];
    CLParsed * mapKey2 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"event_type"];
    CLParsed * mapKey3 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"reserve0"];
    CLParsed * mapKey4 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"reserve1"];
    [parseMapKey.arrayValue addObject:mapKey1];
    [parseMapKey.arrayValue addObject:mapKey2];
    [parseMapKey.arrayValue addObject:mapKey3];
    [parseMapKey.arrayValue addObject:mapKey4];
    //Value generation
    CLParsed * parseMapValue = [[CLParsed alloc] init];
    parseMapValue.itsCLType = [[CLType alloc] init];
    parseMapValue.itsCLType.itsType = CLTYPE_LIST_MAP_VALUE;//This assignment could drop
    parseMapValue.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapValue1 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"d32DE152c0bBFDcAFf5b2a6070Cd729Fc0F3eaCF300a6b5e2abAB035027C49bc"];
    CLParsed * mapValue2 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"sync"];
    CLParsed * mapValue3 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"412949147973569321536747"];
    CLParsed * mapValue4 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"991717147268569848142418"];
    [parseMapValue.arrayValue addObject:mapValue1];
    [parseMapValue.arrayValue addObject:mapValue2];
    [parseMapValue.arrayValue addObject:mapValue3];
    [parseMapValue.arrayValue addObject:mapValue4];
    
    parseMap.innerParsed1 = parseMapKey;
    parseMap.innerParsed2 = parseMapValue;
    NSString * mapSerialization1 = [CLParseSerializeHelper serializeFromCLParse:parseMap];
    XCTAssert([mapSerialization1 isEqualToString:@"0400000015000000636f6e74726163745f7061636b6167655f6861736840000000643332444531353263306242464463414666356232613630373043643732394663304633656143463330306136623565326162414230333530323743343962630a0000006576656e745f747970650400000073796e630800000072657365727665301800000034313239343931343739373335363933323135333637343708000000726573657276653118000000393931373137313437323638353639383438313432343138"]);
    //Map(String,String) 2
    //Test based on the deploy at this address
//https://testnet.cspr.live/deploy/93b24bf34eba63a157b60b696eae83424904263679dff1cd1c8d6d3f3d73afaa
    //please refer to execution_results item 30 to see the real data
    //Key generation
    CLParsed * parseMapKey2 = [[CLParsed alloc] init];
    parseMapKey2.itsCLType = [[CLType alloc] init];
    parseMapKey2.itsCLType.itsType = CLTYPE_LIST_MAP_KEY;//This assignment could drop
    parseMapKey2.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapKey21 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"contract_package_hash"];
    CLParsed * mapKey22 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"event_type"];
    CLParsed * mapKey23 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"from"];
    CLParsed * mapKey24 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"pair"];
    CLParsed * mapKey25 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"to"];
    CLParsed * mapKey26 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"value"];
    [parseMapKey2.arrayValue addObject:mapKey21];
    [parseMapKey2.arrayValue addObject:mapKey22];
    [parseMapKey2.arrayValue addObject:mapKey23];
    [parseMapKey2.arrayValue addObject:mapKey24];
    [parseMapKey2.arrayValue addObject:mapKey25];
    [parseMapKey2.arrayValue addObject:mapKey26];
    //Value generation
    CLParsed * parseMapValue2 = [[CLParsed alloc] init];
    parseMapValue2.itsCLType = [[CLType alloc] init];
    parseMapValue2.itsCLType.itsType = CLTYPE_LIST_MAP_VALUE;//This assignment could drop
    parseMapValue2.arrayValue = [[NSMutableArray alloc] init];
    CLParsed * mapValue21 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"26526c30383e5c02d684ac68d7845e576a87166926f7500bdaa303cdab52aea7"];
    CLParsed * mapValue22 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"transfer"];
    CLParsed * mapValue23 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"Key::Account(8b217a09296d5ce360847a7d20f623476157c5f022333c4e988a464035cadd80)"];
    CLParsed * mapValue24 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"Key::Hash(53a8121f219ad2c6420f007a2016ed320c519579112b81d505cb15715404b264)"];
    CLParsed * mapValue25 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"Key::Hash(26526c30383e5c02d684ac68d7845e576a87166926f7500bdaa303cdab52aea7)"];
    CLParsed * mapValue26 = [CLParsed clParsedWithType:CLTYPE_STRING andValue:@"1763589511"];
    [parseMapValue2.arrayValue addObject:mapValue21];
    [parseMapValue2.arrayValue addObject:mapValue22];
    [parseMapValue2.arrayValue addObject:mapValue23];
    [parseMapValue2.arrayValue addObject:mapValue24];
    [parseMapValue2.arrayValue addObject:mapValue25];
    [parseMapValue2.arrayValue addObject:mapValue26];

    parseMap.innerParsed1 = parseMapKey2;
    parseMap.innerParsed2 = parseMapValue2;
    NSString * mapSerialization2 = [CLParseSerializeHelper serializeFromCLParse:parseMap];
    XCTAssert([mapSerialization2 isEqualToString:@"0600000015000000636f6e74726163745f7061636b6167655f6861736840000000323635323663333033383365356330326436383461633638643738343565353736613837313636393236663735303062646161333033636461623532616561370a0000006576656e745f74797065080000007472616e736665720400000066726f6d4e0000004b65793a3a4163636f756e7428386232313761303932393664356365333630383437613764323066363233343736313537633566303232333333633465393838613436343033356361646438302904000000706169724b0000004b65793a3a4861736828353361383132316632313961643263363432306630303761323031366564333230633531393537393131326238316435303563623135373135343034623236342902000000746f4b0000004b65793a3a486173682832363532366333303338336535633032643638346163363864373834356535373661383731363639323666373530306264616133303363646162353261656137290500000076616c75650a00000031373633353839353131"]);
    
    //Test for CLValue ByteArray serialization
    
    CLParsed * parseByteArray = [[CLParsed alloc] init];
    parseByteArray.itsCLType = [[CLType alloc] init];
    parseByteArray.itsCLType.itsType = CLTYPE_BYTEARRAY;
    parseByteArray.itsValueStr = @"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc";
    NSString * byteArraySerialization = [CLParseSerializeHelper serializeFromCLParseByteArray:parseByteArray];
    XCTAssert([byteArraySerialization isEqualToString:@"006d0be2fb64bcc8d170443fbadc885378fdd1c71975e2ddd349281dd9cc59cc"]);
    
    //Test for CLValue Result serialization
    CLParsed * parseResult = [[CLParsed alloc] init];
    parseResult.itsCLType = [[CLType alloc] init];
    parseResult.itsCLType.itsType = CLTYPE_RESULT;
    //For Result Ok String
    //Take this deploy address https://testnet.cspr.live/deploy/2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61
    //in execution_results item 16
    parseResult.itsValueStr = CLPARSED_RESULT_OK;
    CLParsed * parseResultOk = [[CLParsed alloc] init];
    parseResultOk.itsCLType = [[CLType alloc] init];
    parseResultOk.itsCLType.itsType = CLTYPE_STRING;
    parseResultOk.itsValueStr = @"goodresult";
    parseResult.innerParsed1 = parseResultOk;
    NSString * resultSerialization = [CLParseSerializeHelper serializeFromCLParseResult:parseResult];
    XCTAssert([resultSerialization isEqualToString:@"010a000000676f6f64726573756c74"]);
   
    //For Result Err
    parseResult.itsValueStr = CLPARSED_RESULT_ERR;
    CLParsed * parseResultErr = [[CLParsed alloc] init];
    parseResultErr.itsCLType = [[CLType alloc] init];
    parseResultErr.itsCLType.itsType = CLTYPE_U512;
    parseResultErr.itsValueStr = @"999888666555444999887988887777666655556666777888999666999";
    parseResult.innerParsed1 = parseResultErr;
    NSString * resultSerialization2 = [CLParseSerializeHelper serializeFromCLParseResult:parseResult];
    XCTAssert([resultSerialization2 isEqualToString:@"001837f578fca55492f299ea354eaca52b6e9de47d592453c728"]);
    
   
    //For Result Err2
    //Take this deploy address https://testnet.cspr.live/deploy/2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61
    //in execution_results item 21
    
    parseResult.itsValueStr = CLPARSED_RESULT_ERR;
    CLParsed * parseResultErr2 = [[CLParsed alloc] init];
    parseResultErr2.itsCLType = [[CLType alloc]init];
    parseResultErr2.itsCLType.itsType = CLTYPE_STRING;
    parseResultErr2.itsValueStr = @"badresult";
    parseResult.innerParsed1 = parseResultErr2;
    NSString * resultSerialization3 = [CLParseSerializeHelper serializeFromCLParseResult:parseResult];
    XCTAssert([resultSerialization3 isEqualToString:@"0009000000626164726573756c74"]);
    
    
    //Test for CLValue Tuple1 serialization

    CLParsed * parseTuple1 = [[CLParsed alloc] init];
    parseTuple1.itsCLType = [[CLType alloc] init];
    parseTuple1.itsCLType.itsType = CLTYPE_TUPLE1;
    
    CLParsed * tuple1Inner = [[CLParsed alloc] init];
    tuple1Inner.itsCLType = [[CLType alloc] init];
    tuple1Inner.itsCLType.itsType = CLTYPE_I32;
    tuple1Inner.itsValueStr = @"1000";
    parseTuple1.innerParsed1 = tuple1Inner;
    NSString * tuple1Serialization = [CLParseSerializeHelper serializeFromCLParseTuple1:parseTuple1];
    XCTAssert([tuple1Serialization isEqualToString:@"e8030000"]);
    
    //Test for CLValue Tuple2 serialization
    //Take this deploy address https://testnet.cspr.live/deploy/2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61
    //in execution_results item 31
    CLParsed * parseTuple2 = [[CLParsed alloc] init];
    parseTuple2.itsCLType = [[CLType alloc] init];
    parseTuple2.itsCLType.itsType = CLTYPE_TUPLE2;
    
    CLParsed * tuple2Inner1 = [[CLParsed alloc] init];
    tuple2Inner1.itsCLType = [[CLType alloc] init];
    tuple2Inner1.itsCLType.itsType = CLTYPE_STRING;
    tuple2Inner1.itsValueStr = @"abc";
    parseTuple2.innerParsed1 = tuple2Inner1;
    CLParsed * tuple2Inner2 = [[CLParsed alloc] init];
    tuple2Inner2.itsCLType = [[CLType alloc] init];
    tuple2Inner2.itsCLType.itsType = CLTYPE_U512;
    tuple2Inner2.itsValueStr = @"1";
    parseTuple2.innerParsed2 = tuple2Inner2;
    
    NSString * tuple2Serialization = [CLParseSerializeHelper serializeFromCLParseTuple2:parseTuple2];
    XCTAssert([tuple2Serialization isEqualToString:@"030000006162630101"]);
    
    //Test for CLValue Tuple3 serialization
    //Take this deploy address https://testnet.cspr.live/deploy/2ad794272a1a805082f171f96f1ea0e71fcac3ae6dd0c525343199b553be8a61
    //in execution_results item 36
    
    CLParsed * parseTuple3 = [[CLParsed alloc] init];
    parseTuple3.itsCLType = [[CLType alloc] init];
    parseTuple3.itsCLType.itsType = CLTYPE_TUPLE2;
    //First element: PublicKey
    CLParsed * tuple3Inner1 = [[CLParsed alloc] init];
    tuple3Inner1.itsCLType = [[CLType alloc] init];
    tuple3Inner1.itsCLType.itsType = CLTYPE_PUBLICKEY;
    tuple3Inner1.itsValueStr = @"01a018bf278f32fdb7b06226071ce399713ace78a28d43a346055060a660ba7aa9";
    parseTuple3.innerParsed1 = tuple3Inner1;
    //Second element: Option(String)
    //Option
    CLParsed * tuple3Inner2 = [[CLParsed alloc] init];
    tuple3Inner2.itsCLType = [[CLType alloc] init];
    tuple3Inner2.itsCLType.itsType = CLTYPE_OPTION;
    //String
    CLParsed * tuple3Inner2Inner = [[CLParsed alloc] init];
    tuple3Inner2Inner.itsCLType = [[CLType alloc] init];
    tuple3Inner2Inner.itsCLType.itsType = CLTYPE_STRING;
    tuple3Inner2Inner.itsValueStr = @"abc";
    tuple3Inner2.innerParsed1 = tuple3Inner2Inner;
    parseTuple3.innerParsed2 = tuple3Inner2;
    //Third element: U512
    CLParsed * tuple3Inner3 = [[CLParsed alloc] init];
    tuple3Inner3.itsCLType = [[CLType alloc] init];
    tuple3Inner3.itsCLType.itsType = CLTYPE_U512;
    tuple3Inner3.itsValueStr = @"2";
    parseTuple3.innerParsed3 = tuple3Inner3;

    NSString * tuple3Serialization = [CLParseSerializeHelper serializeFromCLParseTuple3:parseTuple3];
    XCTAssert([tuple3Serialization isEqualToString:@"01a018bf278f32fdb7b06226071ce399713ace78a28d43a346055060a660ba7aa901030000006162630102"]);
}

@end
