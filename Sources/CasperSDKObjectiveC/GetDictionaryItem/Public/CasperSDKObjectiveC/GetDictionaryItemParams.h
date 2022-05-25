#ifndef GetDictionaryItemParams_h
#define GetDictionaryItemParams_h
/**Class built for storing GetBalanceParams information, used for sending state_get_dictionary_item RPC method
 */
#import <Foundation/Foundation.h>
@interface  GetDictionaryItemParams : NSObject
@property NSString * state_root_hash;
///This could be 1 among the 4 possible value of the enum: AccountNamedKey, ContractNamedKey,URef,Dictionary
@property NSString * dictionaryIdentifierType;
///This hold the 1 among 4 possible value of the 4 enum type of the DictionaryIdentifier
@property NSMutableArray * innerDict;
/**This function generate the json data used for sending POST method for state_get_dictionary_item RPC call.
Based on the GetDictionaryItemParams data, the JSON string is built somehow like this:
 
 {"method" : "state_get_dictionary_item","id" : 1,"params" :{"state_root_hash" : "146b860f82359ced6e801cbad31015b5a9f9eb147ab2a449fd5cdb950e961ca8","dictionary_identifier":{"AccountNamedKey":{"dictionary_name":"dict_name","key":"account-hash-ad7e091267d82c3b9ed1987cb780a005a550e6b3d1ca333b743e2dba70680877","dictionary_item_key":"abc_name"}}},"jsonrpc" : "2.0"}
 */
-(NSString *) toJsonString;
@end
#endif
