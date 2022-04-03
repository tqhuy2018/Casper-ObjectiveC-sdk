#import <Foundation/Foundation.h>
#import "NextUpgrade.h"
/**Class built for storing NextUpgrade information
 */
@implementation NextUpgrade
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NextUpgrade object
 */
+(NextUpgrade*) fromJsonDictToNextUpgrade:(NSDictionary*) fromDict {
    NextUpgrade * ret = [[NextUpgrade alloc] init];
    if(fromDict[@"protocol_version"]) {
        ret.protocol_version = fromDict[@"protocol_version"];
    }
    return ret;
}
@end
