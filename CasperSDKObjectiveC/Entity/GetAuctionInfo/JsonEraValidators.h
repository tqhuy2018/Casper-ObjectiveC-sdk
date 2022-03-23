#ifndef JsonEraValidators_h
#define JsonEraValidators_h

@interface JsonEraValidators : NSObject
@property UInt64 era_id;
//List of JsonValidatorWeights
@property NSMutableArray * validator_weights;
+(JsonEraValidators*) fromJsonDictToJsonEraValidators:(NSDictionary*) fromDict;
-(void) logInfo;

@end
#endif 
