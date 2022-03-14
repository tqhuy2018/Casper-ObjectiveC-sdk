#ifndef JsonProof_h
#define JsonProof_h
@interface JsonProof:NSObject
@property NSString * public_key;
@property NSString * signature;
+(NSMutableArray*) fromJsonDictToJsonProofList:(NSArray*) jsonArray;
+(JsonProof*) fromJsonDictToJsonProof:(NSDictionary*) jsonDict;
@end

#endif 
