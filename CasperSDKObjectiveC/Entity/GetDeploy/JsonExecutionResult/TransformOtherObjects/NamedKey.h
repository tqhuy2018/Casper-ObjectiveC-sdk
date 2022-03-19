#ifndef NamedKey_h
#define NamedKey_h
@interface NamedKey:NSObject
@property NSString * name;
@property NSString * key;
+(NamedKey*) fromJsonDictToNamedKey:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
