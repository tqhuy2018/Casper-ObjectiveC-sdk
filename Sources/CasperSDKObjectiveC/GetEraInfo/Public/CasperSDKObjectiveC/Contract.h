#ifndef Contract_h
#define Contract_h
/**Class built for storing Contract information
 */
#import <Foundation/Foundation.h>
@interface Contract : NSObject
@property NSString * contract_package_hash;
@property NSString * contract_wasm_hash;
@property NSMutableArray * entry_points;
@property NSMutableArray * named_keys;
@property NSString * protocol_version;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Contract object
 */
+(Contract*) fromJsonDictToContact:(NSDictionary*) fromDict;
@end
#endif
