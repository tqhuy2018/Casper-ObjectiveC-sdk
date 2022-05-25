#ifndef JsonBlockBody_h
#define JsonBlockBody_h
#import <Foundation/Foundation.h>
/**Class built for storing JsonBlockBody information
 */
@interface JsonBlockBody:NSObject
@property NSMutableArray * deploy_hashes;//list of DeployHash - string
@property NSString * proposer;
@property NSMutableArray * transfer_hashes;//list of DeployHash - string
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonBlockBody object
 */
+(JsonBlockBody*) fromJsonDictToJsonBlockBody:(NSDictionary *) fromDict;
-(void) logInfo;
@end

#endif
