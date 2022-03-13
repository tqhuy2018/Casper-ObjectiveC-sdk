#import "Transfer.h"
#ifndef GetBlockTransfersResult_h
#define GetBlockTransfersResult_h
@interface GetBlockTransfersResult : NSObject
@property NSString * api_version;
@property NSString * block_hash;//optional
@property NSMutableArray * transfers;//optional
@property bool is_transfers_exists;
@property bool is_block_hash_exists;
+(GetBlockTransfersResult *) fromJsonDictToGetBlockTransfersResult:(NSDictionary*) jsonDict;
-(void) logInfo;
@end

#endif 
