#ifndef StoredValue_h
#define StoredValue_h
/**StoredValue is an enum type, which can hold the following values:
CLValue(CLValue),Account(Account),ContractWasm(String),Contract(Contract),ContractPackage(ContractPackage),Transfer(Transfer),DeployInfo(DeployInfo),EraInfo(EraInfo),Bid(Box<Bid>),Withdraw(Vec<UnbondingPurse>),
In which the following values can be retrieve from TransformEntry
1. Transfer(Transfer), 2. DeployInfo(DeployInfo),3. EraInfo(EraInfo),Bid(Box<Bid>),4. Withdraw(Vec<UnbondingPurse>), 5. CLValue(CLValue)
The following has to be implemented
 Account(Account),ContractWasm(String),Contract(Contract),ContractPackage(ContractPackage),
 */
#import <Foundation/Foundation.h>
@interface StoredValue:NSObject
@property NSString* itsType;
///The inner value of the StoredValue, which can hold 1 among 9 possible value of the enum
@property NSMutableArray * innerValue;
+(StoredValue *) fromJsonDictToStoredValue:(NSDictionary*) fromDict;
@end

#endif
