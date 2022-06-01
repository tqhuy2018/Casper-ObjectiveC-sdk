#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonBlockHeader.h>
/**Class built for storing JsonBlockHeader information
 */
@implementation JsonBlockHeader
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlockHeader object
 */
+(JsonBlockHeader*) fromJsonDictToJsonBlockHeader:(NSDictionary*) fromDict {
    JsonBlockHeader * ret = [[JsonBlockHeader alloc] init];
    ret.parent_hash = fromDict[@"parent_hash"];
    ret.state_root_hash = fromDict[@"state_root_hash"];
    ret.body_hash = fromDict[@"body_hash"];
    ret.random_bit = [fromDict[@"random_bit"] boolValue];
    ret.accumulated_seed = fromDict[@"accumulated_seed"];
    ret.timestamp = fromDict[@"timestamp"];
    NSString * era_idStr = fromDict[@"era_id"];
    NSString * heightStr = fromDict[@"height"];
    ret.era_id = [era_idStr longLongValue];
    ret.height = [heightStr longLongValue];
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
@end
