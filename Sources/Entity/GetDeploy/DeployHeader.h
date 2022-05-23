#ifndef DeployHeader_h
#define DeployHeader_h
/**Class built for storing Deploy information
 */
@interface DeployHeader:NSObject
@property NSString * account;
@property NSString * body_hash;
@property NSString * chain_name;
@property NSMutableArray * dependencies;//list of DeployHash in string
@property UInt64 gas_price;
@property NSString * timestamp;
@property NSString * ttl;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to DeployHeader object
 */
+(DeployHeader*) fromJsonDictToDeployHeader:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
