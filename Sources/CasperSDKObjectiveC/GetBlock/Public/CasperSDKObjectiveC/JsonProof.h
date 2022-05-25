#ifndef JsonProof_h
#define JsonProof_h
#import <Foundation/Foundation.h>
/**Class built for storing JsonProof information
 */
@interface JsonProof:NSObject
@property NSString * public_key;
@property NSString * signature;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to get JsonProof list 
 */
+(NSMutableArray*) fromJsonDictToJsonProofList:(NSArray*) jsonArray;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonProof object
 */
+(JsonProof*) fromJsonDictToJsonProof:(NSDictionary*) jsonDict;
@end

#endif 
