#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing U512 value
 */
@implementation U512Class
+(U512Class*) fromStrToClass:(NSString*) value {
    U512Class * ret = [[U512Class alloc] init];
    ret.itsValue = value;
    return ret;
}
@end
