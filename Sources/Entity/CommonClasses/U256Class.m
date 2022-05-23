#import <Foundation/Foundation.h>
#import "U256Class.h"
/**Class built for storing U256 value
 */
@implementation U256Class
+(U256Class*) fromStrToClass:(NSString*) value {
    U256Class * ret = [[U256Class alloc] init];
    ret.itsValue = value;
    return ret;
}
@end
