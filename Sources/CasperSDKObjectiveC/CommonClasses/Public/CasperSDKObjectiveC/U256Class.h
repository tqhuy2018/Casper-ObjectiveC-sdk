#import "BigNumber.h"
#import <Foundation/Foundation.h>
#ifndef U256Class_h
#define U256Class_h
/**Class built for storing U256 value
 */
@interface U256Class:BigNumber
+(U256Class*) fromStrToClass:(NSString*) value;
@end

#endif 
