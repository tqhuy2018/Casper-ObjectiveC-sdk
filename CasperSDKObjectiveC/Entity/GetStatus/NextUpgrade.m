#import <Foundation/Foundation.h>
#import "NextUpgrade.h"
@implementation NextUpgrade
+(NextUpgrade*) fromJsonDictToNextUpgrade:(NSDictionary*) fromDict {
    NextUpgrade * ret = [[NextUpgrade alloc] init];
    if(fromDict[@"protocol_version"]) {
        ret.protocol_version = fromDict[@"protocol_version"];
    }
    return ret;
}
@end
