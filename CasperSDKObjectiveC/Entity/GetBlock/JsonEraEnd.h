#import "JsonEraReport.h"
#ifndef JsonEraEnd_h
#define JsonEraEnd_h
@interface JsonEraEnd:NSObject
@property JsonEraReport * era_report;
@property NSMutableArray * next_era_validator_weights;//list of ValidatorWeight
+(JsonEraEnd*) fromJsonDictToJsonEraEnd:(NSDictionary*) fromDict;
-(void) logInfo;
@end
#endif
