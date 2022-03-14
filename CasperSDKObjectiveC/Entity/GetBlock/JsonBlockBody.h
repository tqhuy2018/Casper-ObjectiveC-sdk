#ifndef JsonBlockBody_h
#define JsonBlockBody_h
@interface JsonBlockBody:NSObject
@property NSMutableArray * deploy_hashes;//list of DeployHash - string
@property NSString * proposer;
@property NSMutableArray * transfer_hashes;//list of DeployHash - string
+(JsonBlockBody*) fromJsonDictToJsonBlockBody:(NSDictionary *) fromDict;
@end

#endif
