#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Parameter.h>
/**Class built for storing Parameter information
 */
@implementation Parameter
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Parameter object
 */
+(Parameter*) fromJsonDictToParameter:(NSDictionary*) fromDict{
    Parameter * ret = [[Parameter alloc] init];
    ret.name = (NSString*) fromDict[@"name"];
    ret.cl_type = [CLType fromObjToCLType:fromDict[@"cl_type"]];
    return ret;
}

@end
