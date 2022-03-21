#ifndef AssociatedKey_h
#define AssociatedKey_h
@interface AssociatedKey : NSObject
@property UInt8 weight;
@property NSString * account_hash;
-(void) logInfo;
@end

#endif
