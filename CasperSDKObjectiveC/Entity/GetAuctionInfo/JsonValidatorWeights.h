#ifndef JsonValidatorWeights_h
#define JsonValidatorWeights_h
#import "U512Class.h"
/**Class built for storing JsonValidatorWeights information
 */
@interface JsonValidatorWeights:NSObject
@property NSString * public_key;
@property U512Class * weight;
/**Generate a JsonValidatorWeights from dictionary object taken from the JSON back from the server when call RPC method
 */
+(JsonValidatorWeights*) fromJsonDictToJsonValidatorWeights:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
