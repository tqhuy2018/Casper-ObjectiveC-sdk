#ifndef PutDeployResult_h
#define PutDeployResult_h
#import <Foundation/Foundation.h>
@interface PutDeployResult:NSObject
@property NSString * apiVersion;
@property NSString * deployHash;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to PutDeployResult object
 */
+(PutDeployResult*) fromJsonObjectToPutDeployResult:(NSDictionary*) fromDict;
@end

#endif
