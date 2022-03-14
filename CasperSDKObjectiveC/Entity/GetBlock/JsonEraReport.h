#ifndef JsonEraReport_h
#define JsonEraReport_h
@interface JsonEraReport:NSObject
@property NSMutableArray * equivocators;//List of PublicKey
@property NSMutableArray * inactive_validators;//List of PublicKey
@property NSMutableArray * rewards;//List of Reward
+(JsonEraReport*) fromJsonDictToJsonEraReport:(NSDictionary *) fromDict;
@end

#endif
