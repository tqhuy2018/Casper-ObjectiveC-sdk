#ifndef JsonEraValidators_h
#define JsonEraValidators_h
#import <Foundation/Foundation.h>
/**Class built for storing JsonEraValidators information
 */
@interface JsonEraValidators : NSObject
@property UInt64 era_id;
//List of JsonValidatorWeights
@property NSMutableArray * validator_weights;
/**Generate a JsonEraValidators from dictionary object taken from the JSON back from the server when call RPC method
 */
+(JsonEraValidators*) fromJsonDictToJsonEraValidators:(NSDictionary*) fromDict;
-(void) logInfo;

@end
#endif 
