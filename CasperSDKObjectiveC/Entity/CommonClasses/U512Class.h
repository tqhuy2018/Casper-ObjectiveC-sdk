#import "BigNumber.h"
#ifndef U512Class_h
#define U512Class_h
/**Class built for storing U512 value
 */
@interface U512Class:BigNumber
+(U512Class*) fromStrToClass:(NSString*) value;
@end

#endif
