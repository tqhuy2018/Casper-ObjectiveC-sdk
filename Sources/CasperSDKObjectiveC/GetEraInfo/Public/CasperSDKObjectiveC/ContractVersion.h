#ifndef ContractVersion_h
#define ContractVersion_h
/**Class built for storing ContractVersion information
 */
#import <Foundation/Foundation.h>
@interface ContractVersion:NSObject
@property NSString * contract_hash;
@property UInt32 contract_version;
@property UInt32 protocol_version_major;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ContractVersion object
 */
+(ContractVersion*) fromJsonDictToContractVersion:(NSDictionary*) fromDict;
@end

#endif
