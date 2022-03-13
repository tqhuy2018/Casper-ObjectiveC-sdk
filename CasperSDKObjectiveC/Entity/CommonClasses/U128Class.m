#import <Foundation/Foundation.h>
#import "U128Class.h"
@implementation U128Class
+(U128Class*) fromStrToClass:(NSString*) value {
    U128Class * ret = [[U128Class alloc] init];
    ret.itsValue = value;
    return ret;
}
@end
