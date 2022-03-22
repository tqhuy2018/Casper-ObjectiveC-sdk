#ifndef GetDictionaryItemResult_h
#define GetDictionaryItemResult_h
#import "StoredValue.h"
@interface GetDictionaryItemResult:NSObject
@property NSString * api_version;
@property NSString *dictionary_key;
@property NSString * merkle_proof;
@property StoredValue * stored_value;
+(GetDictionaryItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict;
-(void)logInfo;
@end

#endif
