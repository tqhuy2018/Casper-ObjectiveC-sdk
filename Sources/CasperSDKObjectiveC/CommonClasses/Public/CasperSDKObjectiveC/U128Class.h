#import "BigNumber.h"
#import <Foundation/Foundation.h>
#ifndef U128Class_h
#define U128Class_h
/**Class built for storing U128 value
 */
@interface U128Class:BigNumber
+(U128Class*) fromStrToClass:(NSString*) value;
@end

#endif 
