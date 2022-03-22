#ifndef GetDictionaryItemParams_h
#define GetDictionaryItemParams_h

@interface  GetDictionaryItemParams : NSObject
@property NSString * state_root_hash;
@property NSString * dictionaryIdentifierType;
@property NSMutableArray * innerDict;
-(NSString *) toJsonString;
@end
#endif
