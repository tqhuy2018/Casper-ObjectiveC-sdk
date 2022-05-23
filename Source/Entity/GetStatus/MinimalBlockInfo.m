#import <Foundation/Foundation.h>
#import "MinimalBlockInfo.h"
/**Class built for storing MinimalBlockInfo information
 */
@implementation MinimalBlockInfo
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to MinimalBlockInfo object
 */
+(MinimalBlockInfo*) fromJsonToMinimalBlockInfo:(NSDictionary *) fromDict {
    MinimalBlockInfo * ret = [[MinimalBlockInfo alloc] init];
    ret.creator = fromDict[@"creator"];
    ret.era_id = (UInt64) fromDict[@"era_id"];
    ret.itsHash = fromDict[@"hash"];
    ret.height = (UInt64) fromDict[@"height"];
    ret.state_root_hash = fromDict[@"state_root_hash"];
    ret.timestamp = fromDict[@"timestamp"];
    return ret;
}
@end
