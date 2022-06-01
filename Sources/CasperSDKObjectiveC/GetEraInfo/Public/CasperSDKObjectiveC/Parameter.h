#ifndef Parameter_h
#define Parameter_h
#import <CasperSDKObjectiveC/CLType.h>
#import <Foundation/Foundation.h>
/**Class built for storing Parameter information
 */
@interface Parameter:NSObject
@property CLType * cl_type;
@property NSString * name;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Parameter object
 */
+(Parameter*) fromJsonDictToParameter:(NSDictionary*) fromDict;
@end

#endif 
