#ifndef NextUpgrade_h
#define NextUpgrade_h
#import "ActivationPoint.h"
@interface NextUpgrade : NSObject
@property NSString * protocol_version;
@property ActivationPoint * activation_point;
+(NextUpgrade*) fromJsonDictToNextUpgrade:(NSDictionary*) fromDict;
@end

#endif
