#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/NamedKey.h>
/**Class built for storing NamedKey information.
 */
@implementation NamedKey
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NamedKey object
 */
+(NamedKey*) fromJsonDictToNamedKey:(NSDictionary*) fromDict {
    NamedKey * ret = [[NamedKey alloc] init];
    ret.key = (NSString*) fromDict[@"key"];
    ret.name = (NSString*) fromDict[@"name"];
    return ret;
}

@end
