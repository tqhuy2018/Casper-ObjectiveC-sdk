#import "JsonBlockHeader.h"
#import "JsonBlockBody.h"
#ifndef JsonBlock_h
#define JsonBlock_h
@interface JsonBlock:NSObject
@property NSString * blockHash;
@property JsonBlockHeader * header;
@property JsonBlockBody * body;
@property NSMutableArray * proofs;
+(JsonBlock*) fromJsonDictToJsonBlock:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
