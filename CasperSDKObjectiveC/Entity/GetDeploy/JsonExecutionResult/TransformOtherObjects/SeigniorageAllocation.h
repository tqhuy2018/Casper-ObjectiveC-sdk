#ifndef SeigniorageAllocation_h
#define SeigniorageAllocation_h
#import "U512Class.h"
///Class of type enum,
///see this address https://docs.rs/casper-types/1.4.6/casper_types/system/auction/enum.SeigniorageAllocation.html
@interface SeigniorageAllocation : NSObject
@property NSString * validator_public_key;
@property NSString * delegator_public_key; //This is for enum type Delegator
@property U512Class * amount;
@property bool isDelegatorEnum;
+(SeigniorageAllocation*) fromJsonDictToSeigniorageAllocation:(NSDictionary*) fromDict;
-(void) logInfo;
@end
#endif
