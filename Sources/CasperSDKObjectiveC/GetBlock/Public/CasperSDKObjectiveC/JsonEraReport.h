#ifndef JsonEraReport_h
#define JsonEraReport_h
#import <Foundation/Foundation.h>
/**Class built for storing JsonEraReport information
 */
@interface JsonEraReport:NSObject
@property NSMutableArray * equivocators;//List of PublicKey
@property NSMutableArray * inactive_validators;//List of PublicKey
@property NSMutableArray * rewards;//List of Reward
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonEraReport object
 */
+(JsonEraReport*) fromJsonDictToJsonEraReport:(NSDictionary *) fromDict;
@end

#endif
