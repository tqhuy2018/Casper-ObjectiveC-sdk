#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/U128Class.h>
/**Class built for storing U128 value
 */
@implementation U128Class
+(U128Class*) fromStrToClass:(NSString*) value {
    U128Class * ret = [[U128Class alloc] init];
    ret.itsValue = value;
    return ret;
}
@end
