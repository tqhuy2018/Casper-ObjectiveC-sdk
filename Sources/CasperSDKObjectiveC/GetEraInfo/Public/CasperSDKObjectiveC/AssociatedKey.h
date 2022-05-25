#ifndef AssociatedKey_h
#define AssociatedKey_h
/**Class built for storing AssociatedKey information
 */
#import <Foundation/Foundation.h>
@interface AssociatedKey : NSObject
@property UInt8 weight;
@property NSString * account_hash;
-(void) logInfo;
@end

#endif
