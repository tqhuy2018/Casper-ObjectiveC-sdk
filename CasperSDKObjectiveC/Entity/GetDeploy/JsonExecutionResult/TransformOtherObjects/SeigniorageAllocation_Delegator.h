#ifndef SeigniorageAllocation_Delegator_h
#define SeigniorageAllocation_Delegator_h
#import "U512Class.h"
@interface SeigniorageAllocation_Delegator:NSObject
@property NSString * delegator_public_key;
@property NSString * validator_public_key;
@property U512Class * amount;
@end

#endif
