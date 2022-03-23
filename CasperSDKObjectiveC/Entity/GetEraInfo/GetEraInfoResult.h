#ifndef GetEraInfoResult_h
#define GetEraInfoResult_h
#import "EraSummary.h"
@interface GetEraInfoResult:NSObject
@property NSString * api_version;
///EraSummary value which is optional
@property EraSummary * era_summary;
///Bool value to check whether the era_summary exist or not
@property bool is_era_summary_existed;
+(GetEraInfoResult*) fromJsonDictToGetEraInfoResult:(NSDictionary*) fromDict;
+(void) getEraInfoWithParams:(NSString*) jsonString;
-(void)logInfo;
@end

#endif 
