#ifndef DeployInfo_h
#define DeployInfo_h
#import "U512Class.h"
///Object to use in Transform Enum in type WriteDeployInfo
@interface DeployInfo:NSObject
///Deploy hash in type of String
@property NSString * deploy_hash;
///List of Transfer in type of String
@property NSMutableArray * transfers;
///From, of type AccountHash
@property NSString * from;
///Source, of type URef, in  String
@property NSString * source;
///Gas, of type U512 class
@property U512Class * gas;
+(DeployInfo * ) fromJsonDictToDeployInfo:(NSDictionary*) fromDict;
@end

#endif
