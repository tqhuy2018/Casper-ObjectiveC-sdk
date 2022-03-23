#ifndef JsonValidatorWeights_h
#define JsonValidatorWeights_h
#import "U512Class.h"
@interface JsonValidatorWeights:NSObject
@property NSString * public_key;
@property U512Class * weight;
+(JsonValidatorWeights*) fromJsonDictToJsonValidatorWeights:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
