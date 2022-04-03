#import <Foundation/Foundation.h>
#import "GetDictionaryItemParams.h"
#import "DictionaryIdentifier_AccountNamedKey.h"
#import "DictionaryIdentifier_ContractNamedKey.h"
#import "DictionaryIdentifier_URef.h"
#import "DictionaryIdentifier_Dictionary.h"
#import "DictionaryIdentifier_ContractNamedKey.h"
#import "DictionaryIdentifier_URef.h"
#import "DictionaryIdentifier_Dictionary.h"
/**Class built for storing GetBalanceParams information, used for sending state_get_dictionary_item RPC method
 */
@implementation GetDictionaryItemParams
/**This function generate the json data used for sending POST method for state_get_dictionary_item RPC call.
Based on the GetDictionaryItemParams data, the JSON string is built somehow like this:
 
 {"method" : "state_get_dictionary_item","id" : 1,"params" :{"state_root_hash" : "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8","dictionary_identifier":{"AccountNamedKey":{"dictionary_name":"dict_name","key":"account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877","dictionary_item_key":"abc_name"}}},"jsonrpc" : "2.0"}
 */
-(NSString *) toJsonString {
    NSString * ret = @"";
    //AccountNamedKey
    if ([self.dictionaryIdentifierType isEqualToString:@"AccountNamedKey"]) {
        DictionaryIdentifier_AccountNamedKey * item = (DictionaryIdentifier_AccountNamedKey*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_dictionary_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"AccountNamedKey\":{\"dictionary_name\":\"%@\",\"key\":\"%@\",\"dictionary_item_key\":\"%@\"}}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.dictionary_name,item.key,item.dictionary_item_key];
    } else if ([self.dictionaryIdentifierType isEqualToString:@"ContractNamedKey"]) {
        DictionaryIdentifier_ContractNamedKey * item = (DictionaryIdentifier_ContractNamedKey*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_dictionary_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"ContractNamedKey\":{\"dictionary_name\":\"%@\",\"key\":\"%@\",\"dictionary_item_key\":\"%@\"}}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.dictionary_name,item.key,item.dictionary_item_key];
    }  else if ([self.dictionaryIdentifierType isEqualToString:@"URef"]) {
        DictionaryIdentifier_URef * item = (DictionaryIdentifier_URef*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_dictionary_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"URef\":{\"seed_uref\":\"%@\",\"dictionary_item_key\":\"%@\"}}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.seed_uref,item.dictionary_item_key];
    } else if ([self.dictionaryIdentifierType isEqualToString:@"Dictionary"]) {
        DictionaryIdentifier_Dictionary * item = (DictionaryIdentifier_Dictionary*) [self.innerDict objectAtIndex:0];
        ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_dictionary_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"dictionary_identifier\":{\"Dictionary\":\"%@\"}},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,item.itsValue];
    }
    return ret;
}
@end
