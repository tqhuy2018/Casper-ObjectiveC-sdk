
#ifndef GetBalanceResult_h
#define GetBalanceResult_h
#import "U512Class.h"
@interface GetBalanceResult:NSObject
@property NSString * api_version;
@property U512Class * balance_value;
@property NSString * merkle_proof;
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict;
+(void) getBalanceWithParams:(NSString*) jsonString;
-(void) logInfo;
@end

#endif
