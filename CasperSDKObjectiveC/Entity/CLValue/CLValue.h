#ifndef CLValue_h
#define CLValue_h
#import "CLType.h"
#import "CLParsed.h"
@interface CLValue:NSObject
@property NSString * bytes;
@property CLType * cl_type;
@property CLParsed * parsed;
+(CLValue*) fromJsonDictToCLParsed:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
