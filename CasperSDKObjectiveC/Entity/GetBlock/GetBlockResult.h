#import "JsonBlock.h"

#ifndef GetBlockResult_h
#define GetBlockResult_h
@interface GetBlockResult:NSObject
@property NSString * api_version;
@property JsonBlock * block;
@property bool is_block_exists;
+(GetBlockResult*) fromJsonDictToGetBlockResult:(NSDictionary *) jsonDict;
-(void) logInfo;
@end

#endif
