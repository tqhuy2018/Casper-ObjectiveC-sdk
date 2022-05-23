#ifndef NextUpgrade_h
#define NextUpgrade_h
#import "ActivationPoint.h"
/**Class built for storing NextUpgrade information
 */
@interface NextUpgrade : NSObject
@property NSString * protocol_version;
@property ActivationPoint * activation_point;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NextUpgrade object
 */
+(NextUpgrade*) fromJsonDictToNextUpgrade:(NSDictionary*) fromDict;
@end

#endif
