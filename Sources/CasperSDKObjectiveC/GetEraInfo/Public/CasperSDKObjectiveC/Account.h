#ifndef Account_h
#define Account_h
#import <Foundation/Foundation.h>
#import "ActionThresholds.h"
/**Class built for storing Account information
 */
@interface Account:NSObject
///AccountHash
@property NSString * account_hash;
///Main purse of type URef
@property NSString * main_purse;
///List of NamedKey
@property NSMutableArray * named_keys;
///List of AssociatedKey
@property NSMutableArray * associated_keys;
///ActionThresholds
@property ActionThresholds * action_thresholds;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Account object
 */
+(Account*) fromJsonDictToAccount:(NSDictionary *) fromDict;
@end

#endif 
