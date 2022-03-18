#ifndef Transfer_h
#define Transfer_h
#import "U512Class.h"
@interface Transfer:NSObject
@property NSString * deploy_hash;
@property NSString * from;
@property NSString * to;//Optional
@property bool is_to_exists;
///source of URef
@property NSString * source;
///target of URef
@property NSString * target;
@property U512Class * amount;
@property U512Class * gas;
@property UInt64 id;//Optional
@property bool is_id_exists;
@end

#endif
