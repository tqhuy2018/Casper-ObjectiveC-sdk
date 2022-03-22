#ifndef Account_h
#define Account_h
#import "ActionThresholds.h"
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
+(Account*) fromJsonDictToAccount:(NSDictionary *) fromDict;
-(void) logInfo;
@end

#endif 
