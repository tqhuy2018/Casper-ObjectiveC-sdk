#import "JsonBlockHeader.h"
#import "JsonBlockBody.h"
#import <Foundation/Foundation.h>
#ifndef JsonBlock_h
#define JsonBlock_h
/**Class built for storing JsonBlock information
 */
@interface JsonBlock:NSObject
@property NSString * blockHash;
@property JsonBlockHeader * header;
@property JsonBlockBody * body;
@property NSMutableArray * proofs;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlock object
 */
+(JsonBlock*) fromJsonDictToJsonBlock:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
