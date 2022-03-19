#ifndef DeployInfo_h
#define DeployInfo_h
#import "U512Class.h"
///Object to use in Transform Enum in type WriteDeployInfo
@interface DeployInfo:NSObject
///Deploy hash in type of String
@property NSString * deploy_hash;
///List of Transfer in type of String, with 1 element in the list with value like this: transfer-38c24e8f3871fa3d3a30db11a0a41681f030ff3dccc252da4e4ac585bb878324
///List of Transfer can be blank
@property NSMutableArray * transfers;
@property bool is_transfers_blank;
///From, of type AccountHash
@property NSString * from;
///Source, of type URef, in  String
@property NSString * source;
///Gas, of type U512 class
@property U512Class * gas;
+(DeployInfo * ) fromJsonDictToDeployInfo:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
