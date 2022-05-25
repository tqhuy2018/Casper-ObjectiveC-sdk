#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/ObjectToJsonStringHelper.h>
@implementation ObjectToJsonStringHelper
/// Function to turn 1 CLValue object to Json string, used for account_put_deploy RPC method call.
+(NSString *) clValueToJsonString:(CLValue *) fromCLValue {
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
+(NSString *) namedArgToJsonString:(NamedArg*) fromNA {
    NSString * clValueStr = [CLValue toJsonString: fromNA.itsCLValue];
    NSString * ret = [[NSString alloc] initWithFormat:@"[\"%@\",%@]",fromNA.itsName,clValueStr];
    return ret;
}
@end
