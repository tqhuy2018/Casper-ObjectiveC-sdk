#ifndef Parameter_h
#define Parameter_h
#import "CLType.h"
@interface Parameter:NSObject
@property CLType * cl_type;
@property NSString * name;
+(Parameter*) fromJsonDictToParameter:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
