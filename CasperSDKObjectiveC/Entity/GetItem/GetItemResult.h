#ifndef GetItemResult_h
#define GetItemResult_h
#import "StoredValue.h"
@interface GetItemResult:NSObject
@property NSString * api_version;
@property NSString * merkle_proof;
@property StoredValue * stored_value;
+(GetItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict;
+(void) getItemWithParams:(NSString*) jsonString;
-(void)logInfo;
@end

#endif 
