#import <Foundation/Foundation.h>
#import "ExecutableDeployItemSerializationHelper.h"
#import "ConstValues.h"

#import "ExecutableDeployItem_ModuleBytes.h"
#import "ExecutableDeployItem_StoredContractByHash.h"
#import "ExecutableDeployItem_StoredContractByName.h"
#import "ExecutableDeployItem_StoredVersionedContractByHash.h"
#import "ExecutableDeployItem_StoredVersionedContractByName.h"
#import "ExecutableDeployItem_Transfer.h"

#import "CLParseSerializeHelper.h"
#import "NumberSerialize.h"
#import "NamedArg.h"
#import "CLParsed.h"
#import "CLValue.h"
#import "CLType.h"
#import "CLTypeSerializeHelper.h"
@implementation ExecutableDeployItemSerializationHelper
+(NSString*) serializeForExecutableDeployItem:(ExecutableDeployItem*) input {
    NSString * ret = @"";
    //Serialization for ModuleBytes
    if([input.itsType isEqualToString:EDI_MODULEBYTES]) {
        //prefix 00 for ExecutableDeployItem as type ModuleBytes
        ret = @"00";
        //get the ExecutableDeployItem_ModuleBytes real object
        ExecutableDeployItem_ModuleBytes * realItem = (ExecutableDeployItem_ModuleBytes*) [input.itsValue objectAtIndex:0];
        //serialization for module_bytes
        //if module_bytes is blank, just return U32 serialization for value 0, which equals to "00000000"
        NSString * moduleBytesSerialization = @"";
        if ([realItem.module_bytes isEqualToString:@""]) {
            moduleBytesSerialization = [NumberSerialize serializeForU32:@"0"];
        } else { //if module_bytes is not blank then the serialization of module_bytes is just string serialization
            CLParsed * parseString = [[CLParsed alloc] init];
            parseString.itsCLTypeStr = CLTYPE_STRING;
            parseString.itsValueStr = realItem.module_bytes;
            moduleBytesSerialization = [CLParseSerializeHelper serializeFromCLParseString:parseString];
        }
        ret = [NSString stringWithFormat:@"%@%@",ret,moduleBytesSerialization];
        NSString * runtimeArgsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        ret = [NSString stringWithFormat:@"%@%@",ret,runtimeArgsSerialization];
    } else if ([input.itsType isEqualToString:EDI_STORED_CONTRACT_BY_HASH]) {
        //prefix 01 for ExecutableDeployItem as type StoredContractByHash
        //the result = "01" + hash + String.Serialize(entry_point) + Args.Serialized
        ret = @"01";
        ExecutableDeployItem_StoredContractByHash * realItem = (ExecutableDeployItem_StoredContractByHash*) [input.itsValue objectAtIndex:0];
        NSString * entryPointSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.entry_point]];
        NSString * argsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        //ret = "01" + hash + String.Serialize(entry_point) + Args.Serialized
        ret = [NSString stringWithFormat:@"%@%@%@%@",ret,realItem.itsHash,entryPointSerialization,argsSerialization];
        return ret;
    } else if ([input.itsType isEqualToString:EDI_STORED_CONTRACT_BY_NAME]) {
        //prefix 02 for ExecutableDeployItem as type StoredContractByName
        //the result = "02" + String.Serialize(name) + String.Serialize(entry_point) + Args.Serialized
        ret = @"02";
        ExecutableDeployItem_StoredContractByName * realItem = (ExecutableDeployItem_StoredContractByName*) [input.itsValue objectAtIndex:0];
        NSString * nameSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.name]];
        NSString * entryPointSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.entry_point]];
        NSString * argsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        // ret = "02" + String.Serialize(name) + String.Serialize(entry_point) + Args.Serialized
        ret = [NSString stringWithFormat:@"%@%@%@%@",ret,nameSerialization,entryPointSerialization,argsSerialization];
        return ret;
    } else if ([input.itsType isEqualToString:EDI_STORED_VERSIONED_CONTRACT_BY_HASH]) {
        ret = @"03";
        //prefix 03 for ExecutableDeployItem as type StoredVersionedContractByHash
        //the result = "03" + hash + Option(U32).Serialize(version) + String.Serialize(entry_point) + Args.Serialized
        ExecutableDeployItem_StoredVersionedContractByHash * realItem = (ExecutableDeployItem_StoredVersionedContractByHash*) [input.itsValue objectAtIndex:0];
        //Get the Option(U32).Serialize(version)
        CLParsed * parseOption = [[CLParsed alloc] init];
        parseOption.itsCLTypeStr = CLTYPE_OPTION;
        if(realItem.is_version_exists) { //version of type Option(U32)
            CLParsed * u32 = [[CLParsed alloc] init];
            u32.itsCLTypeStr = CLTYPE_U32;
            u32.itsValueStr = [NSString stringWithFormat:@"%i",realItem.version];
            parseOption.innerParsed1 = u32;
        } else {//version of type Option(NULL)
            parseOption.itsValueStr = CLPARSED_NULL_VALUE;
        }
        NSString * versionSerialization = [CLParseSerializeHelper serializeFromCLParseOption:parseOption];
        //Get entry_point serialization, just String Serialization over the entry_point
        NSString * entryPointSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.entry_point]];
        //Get the args serialization
        NSString * argsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        //ret = "03" + hash + Option(U32).Serialize(version) + String.Serialize(entry_point) + Args.Serialized
        ret = [NSString stringWithFormat:@"%@%@%@%@%@",ret,realItem.itsHash,versionSerialization,entryPointSerialization,argsSerialization];
        return ret;
    } else if ([input.itsType isEqualToString:EDI_STORED_VERSIONED_CONTRACT_BY_NAME]) {
        ret = @"04";
        //prefix 04 for ExecutableDeployItem as type StoredVersionedContractByName
        //the result = "04" + String.Serialize(name) + Option(U32).Serialize(version) + String.Serialize(entry_point) + Args.Serialized
        ExecutableDeployItem_StoredVersionedContractByName * realItem = (ExecutableDeployItem_StoredVersionedContractByName*) [input.itsValue objectAtIndex:0];
        NSString * nameSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.name]];
        
        //Get the Option(U32).Serialize(version)
        CLParsed * parseOption = [[CLParsed alloc] init];
        parseOption.itsCLTypeStr = CLTYPE_OPTION;
        if(realItem.is_version_exists) { //version of type Option(U32)
            CLParsed * u32 = [[CLParsed alloc] init];
            u32.itsCLTypeStr = CLTYPE_U32;
            u32.itsValueStr = [NSString stringWithFormat:@"%i",realItem.version];
            parseOption.innerParsed1 = u32;
        } else {//version of type Option(NULL)
            parseOption.itsValueStr = CLPARSED_NULL_VALUE;
        }
        NSString * versionSerialization = [CLParseSerializeHelper serializeFromCLParseOption:parseOption];
        
        NSString * entryPointSerialization = [CLParseSerializeHelper serializeFromCLParseString:[CLParsed clParsedWithType:CLTYPE_STRING andValue:realItem.entry_point]];
        NSString * argsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        // ret = "04" + String.Serialize(name) + Option(U32).Serialize(version) + String.Serialize(entry_point) + Args.Serialized
        ret = [NSString stringWithFormat:@"%@%@%@%@%@",ret,nameSerialization,versionSerialization,entryPointSerialization,argsSerialization];
        return ret;
    } else if ([input.itsType isEqualToString:EDI_TRANSFER]) {
        ret = @"05";
        //prefix 05 for ExecutableDeployItem as type Trasfer
        //the result = "05" + Args.Serialized
        ExecutableDeployItem_Transfer * realItem = (ExecutableDeployItem_Transfer*) [input.itsValue objectAtIndex:0];
        NSString * argsSerialization = [ExecutableDeployItemSerializationHelper serializeForRuntimeArgs:realItem.args];
        // ret = "05" + Args.Serialized
        ret = [NSString stringWithFormat:@"%@%@",ret,argsSerialization];
    }
    return ret;
}
///serialization for NameArgList, which stored in RuntimeArgs class
+(NSString *) serializeForRuntimeArgs:(RuntimeArgs*) input {
    NSString * ret = @"";
    int totalNamedArg = (int) input.listArgs.count;
    //If args is emtpy, just return "00000000" - same as U32 serialization for 0 (0 item)
    if(totalNamedArg == 0) {
        return @"00000000";
    }
    //if args is not empty, first take u32 serialization for the number of args
    ret = [NumberSerialize serializeForU32:[NSString stringWithFormat:@"%i",totalNamedArg]];
    //then take serialization for each NamedArgs
    for(int i = 0 ; i < totalNamedArg; i++) {
        NamedArg * oneNA = (NamedArg*) [input.listArgs objectAtIndex:i];
        //Serialization for NamedArg.itsName, just the String serialize on itsName
        CLParsed * nameParsed = [CLParsed clParsedWithType: CLTYPE_STRING andValue:oneNA.itsName];
        NSString * nameSerialization = [CLParseSerializeHelper serializeFromCLParseString:nameParsed];
        //Serialization for NamedArg.itsCLValue
        //The flow of doing this: First serialize the CLValue parse - let call parsedSerialization
        //Serialize CLType - let call it clTypeSerialization
        //result = U32.serialize(parsedSerialization.length) + parsedSerialization + clTypeSerialization
        CLValue * clValue = oneNA.itsCLValue;
        NSString * parsedSerialization = [CLParseSerializeHelper serializeFromCLParse:clValue.parsed];
        int parseLength = (int) [parsedSerialization length];
        parseLength = parseLength/2;
        NSString * parseLengthSerialization = [NumberSerialize serializeForU32:[NSString stringWithFormat:@"%i",parseLength]];
        NSString * clTypeSerialization = [CLTypeSerializeHelper serializeForCLType:clValue.cl_type];
        NSString * clValueSerialization = [NSString stringWithFormat:@"%@%@%@",parseLengthSerialization,parsedSerialization,clTypeSerialization];
        //The last result for one NamedArg serialization is just the concatenation of nameSerialization and clValueSerialization
        NSString * oneNASerialization = [NSString stringWithFormat:@"%@%@",nameSerialization,clValueSerialization];
        //Concatenate each NamedArg serialization to final result
        ret = [NSString stringWithFormat:@"%@%@",ret,oneNASerialization];
    }
    return ret;
}
@end
