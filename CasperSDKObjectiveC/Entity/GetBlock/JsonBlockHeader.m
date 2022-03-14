#import <Foundation/Foundation.h>
#import "JsonBlockHeader.h"
@implementation JsonBlockHeader
+(JsonBlockHeader*) fromJsonDictToJsonBlockHeader:(NSDictionary*) fromDict {
    JsonBlockHeader * ret = [[JsonBlockHeader alloc] init];
    ret.parent_hash = fromDict[@"parent_hash"];
    ret.state_root_hash = fromDict[@"state_root_hash"];
    ret.body_hash = fromDict[@"body_hash"];
    ret.random_bit = (bool) fromDict[@"random_bit"];
    ret.accumulated_seed = fromDict[@"accumulated_seed"];
    ret.timestamp = fromDict[@"timestamp"];
    ret.era_id = (UInt64) fromDict[@"era_id"];
    ret.height = (UInt64) fromDict[@"height"];
    ret.protocol_version = fromDict[@"protocol_version"];
    ret.is_era_end_exists = true;
    if(![fromDict[@"era_end"] isEqual:[NSNull null]]) {
        ret.era_end = [[JsonEraEnd alloc] init];
        ret.era_end = [JsonEraEnd fromJsonDictToJsonEraEnd:fromDict[@"era_end"]];
    } else {
        ret.is_era_end_exists = false;
    }
    return ret;
}
-(void) logInfo{
    NSLog(@"JsonBlockHeader, parent_hash:%@",self.parent_hash);
}
@end
