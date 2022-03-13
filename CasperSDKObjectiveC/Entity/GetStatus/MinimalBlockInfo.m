#import <Foundation/Foundation.h>
#import "MinimalBlockInfo.h"
@implementation MinimalBlockInfo
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
