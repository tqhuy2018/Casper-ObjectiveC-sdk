#import <Foundation/Foundation.h>
#import "GetDictionaryItemParams.h"
#import "DictionaryIdentifier_AccountNamedKey.h"
#import "DictionaryIdentifier_ContractNamedKey.h"
#import "DictionaryIdentifier_URef.h"
#import "DictionaryIdentifier_Dictionary.h"
#import "DictionaryIdentifier_ContractNamedKey.h"
#import "DictionaryIdentifier_URef.h"
#import "DictionaryIdentifier_Dictionary.h"
@implementation GetDictionaryItemParams
-(NSString *) toJsonString {
    NSString * ret = @"";
    //AccountNamedKey
    if ([self.dictionaryIdentifierType isEqualToString:@"AccountNamedKey"]) {
        DictionaryIdentifier_AccountNamedKey * item = (DictionaryIdentifier_AccountNamedKey*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"AccountNamedKey\":{\"dictionary_name\":\"%@\",\"key\":\"%@\",\"dictionary_item_key\":\"%@\"}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.dictionary_name,item.key,item.dictionary_item_key];
    } else if ([self.dictionaryIdentifierType isEqualToString:@"ContractNamedKey"]) {
        DictionaryIdentifier_ContractNamedKey * item = (DictionaryIdentifier_ContractNamedKey*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"ContractNamedKey\":{\"dictionary_name\":\"%@\",\"key\":\"%@\",\"dictionary_item_key\":\"%@\"}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.dictionary_name,item.key,item.dictionary_item_key];
    }  else if ([self.dictionaryIdentifierType isEqualToString:@"URef"]) {
        DictionaryIdentifier_URef * item = (DictionaryIdentifier_URef*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"URef\":{\"seed_uref\":\"%@\",\"dictionary_item_key\":\"%@\"}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.seed_uref,item.dictionary_item_key];
    } else if ([self.dictionaryIdentifierType isEqualToString:@"Dictionary"]) {
        DictionaryIdentifier_Dictionary * item = (DictionaryIdentifier_Dictionary*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"Dictionary\":\"%@\"},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.itsValue];
    }
    return ret;
}
@end
