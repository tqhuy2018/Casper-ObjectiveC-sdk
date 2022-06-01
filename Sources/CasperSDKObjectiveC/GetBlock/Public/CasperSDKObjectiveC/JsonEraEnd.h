#import "JsonEraReport.h"
#import <Foundation/Foundation.h>
#ifndef JsonEraEnd_h
#define JsonEraEnd_h
/**Class built for storing JsonEraEnd information
 */
@interface JsonEraEnd:NSObject
@property JsonEraReport * era_report;
@property NSMutableArray * next_era_validator_weights;//list of ValidatorWeight
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonEraEnd object
 */
+(JsonEraEnd*) fromJsonDictToJsonEraEnd:(NSDictionary*) fromDict;
@end
#endif
