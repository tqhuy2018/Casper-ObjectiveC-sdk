#ifndef Groups_h
#define Groups_h
@interface Groups:NSObject
@property NSString * group;
///List of Key of type URef
@property NSMutableArray * keys;
+(Groups*) fromJSonDictToGroups:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
