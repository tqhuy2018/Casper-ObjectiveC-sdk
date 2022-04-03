#ifndef CLValue_h
#define CLValue_h
#import "CLType.h"
#import "CLParsed.h"
/**Class built for storing the  CLValue object.
 Information of a sample CLValue object
 {
 "bytes":"0400e1f505"
 "parsed":"100000000"
 "cl_type":"U512"
 }
 */
@interface CLValue:NSObject
@property NSString * bytes;
@property CLType * cl_type;
@property CLParsed * parsed;
///Generate the CLValue object  from the dictionary object  fromDict
+(CLValue*) fromJsonDictToCLValue:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
