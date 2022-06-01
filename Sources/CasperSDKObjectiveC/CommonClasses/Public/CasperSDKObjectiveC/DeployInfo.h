#ifndef DeployInfo_h
#define DeployInfo_h
#import <CasperSDKObjectiveC/U512Class.h>
#import <Foundation/Foundation.h>
/**Class built for storing DeployInfo information.
 */
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
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to DeployInfo object
 */
+(DeployInfo * ) fromJsonDictToDeployInfo:(NSDictionary*) fromDict;
@end

#endif
