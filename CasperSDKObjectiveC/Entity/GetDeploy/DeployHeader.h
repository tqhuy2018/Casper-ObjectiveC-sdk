#ifndef DeployHeader_h
#define DeployHeader_h
@interface DeployHeader:NSObject
@property NSString * account;
@property NSString * body_hash;
@property NSString * chain_name;
@property NSMutableArray * dependencies;//list of DeployHash in string
@property UInt64 gas_price;
@property NSString * timestamp;
@property NSString * ttl;
+(DeployHeader*) fromJsonDictToDeployHeader:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif 
