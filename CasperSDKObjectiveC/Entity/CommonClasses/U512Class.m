#import <Foundation/Foundation.h>
#import "U512Class.h"
@implementation U512Class
+(U512Class*) fromStrToClass:(NSString*) value {
    U512Class * ret = [[U512Class alloc] init];
    ret.itsValue = value;
    return ret;
}
@end
