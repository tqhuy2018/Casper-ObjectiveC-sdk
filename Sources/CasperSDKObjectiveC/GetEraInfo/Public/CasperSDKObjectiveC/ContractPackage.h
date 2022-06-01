#ifndef ContractPackage_h
#define ContractPackage_h
/**Class built for storing ContractPackage information
 */
#import <Foundation/Foundation.h>
@interface ContractPackage:NSObject
///Access key of type URef
@property NSString * access_key;
///List of DisabledVersion;
@property NSMutableArray * disabled_versions;
///List of Group
@property NSMutableArray * groups;
///List of ContractVersion
@property NSMutableArray * versions;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to ContractPackage object
 */
+(ContractPackage*) fromJsonDictToContractPackage:(NSDictionary*) fromDict;
@end

#endif
