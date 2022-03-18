#ifndef SeigniorageAllocation_Validator_h
#define SeigniorageAllocation_Validator_h
#import "U512Class.h"
@interface SeigniorageAllocation_Validator:NSObject
@property NSString * validator_public_key;
@property U512Class * amount;
@end

#endif
