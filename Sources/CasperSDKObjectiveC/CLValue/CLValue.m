#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/CLValue.h>
#import <CasperSDKObjectiveC/CLType.h>
#import <CasperSDKObjectiveC/CLParsed.h>
#import <CasperSDKObjectiveC/ConstValues.h>
/**Class built for storing the  CLValue object.
 Information of a sample CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 */
@implementation CLValue
///Generate the CLValue object  from the dictionary object  fromDict
+(CLValue*) fromJsonDictToCLValue:(NSDictionary*) fromDict {
    CLValue * ret = [[CLValue alloc] init];
    ret.bytes = fromDict[@"bytes"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    ret.parsed = [CLParsed fromObjToCLParsed:fromDict[@"parsed"] withCLType:ret.cl_type];
    return ret;
}

+(NSString *) toJsonString:(CLValue *) fromCLValue {
    NSString * ret = @"";
    NSString * clTypeJsonString = [CLType toJsonString:fromCLValue.cl_type];
    NSString * clParseJsonString = [CLParsed toJsonString:fromCLValue.parsed];
    NSString * findStr = [[NSString alloc] initWithFormat:@"%@:",PARSED_FIXED_STR];
    clParseJsonString = [clParseJsonString stringByReplacingOccurrencesOfString:findStr withString:@""];
    NSString * bytesStr= [CLParseSerializeHelper serializeFromCLParse:fromCLValue.parsed];
    bytesStr = [[NSString alloc] initWithFormat:@"\"bytes\": \"%@\"",bytesStr];
    if (fromCLValue.cl_type.itsType == CLTYPE_BYTEARRAY) {
        clTypeJsonString = [[NSString alloc] initWithFormat:@"\"cl_type\": %@",clTypeJsonString];
    } else {
        clTypeJsonString = [[NSString alloc] initWithFormat:@"\"cl_type\": %@",clTypeJsonString];
    }
    if (fromCLValue.cl_type.itsType == CLTYPE_KEY) {
        clParseJsonString = [[NSString alloc] initWithFormat:@"\"parsed\": %@",clParseJsonString];
    } else {
        clParseJsonString = [[NSString alloc] initWithFormat:@"\"parsed\": \"%@\"",clParseJsonString];
    }
    ret = [[NSString alloc] initWithFormat:@"{%@,%@,%@}",bytesStr,clParseJsonString,clTypeJsonString];
    return ret;
}
@end
