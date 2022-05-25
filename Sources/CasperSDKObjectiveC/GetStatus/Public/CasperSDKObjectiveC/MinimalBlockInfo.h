#ifndef MinimalBlockInfo_h
#define MinimalBlockInfo_h
/**Class built for storing MinimalBlockInfo information
 */
#import <Foundation/Foundation.h>
@interface MinimalBlockInfo : NSObject
@property NSString * creator;
@property UInt64 era_id;
@property NSString * itsHash;
@property UInt64 height;
@property NSString * state_root_hash;
@property NSString * timestamp;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to MinimalBlockInfo object
 */
+(MinimalBlockInfo*) fromJsonToMinimalBlockInfo : (NSDictionary *) fromDict;
@end

#endif 
