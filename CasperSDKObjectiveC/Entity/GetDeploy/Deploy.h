#ifndef Deploy_h
#define Deploy_h
#import "DeployHeader.h"
#import "ExecutableDeployItem.h"
/**Class built for storing Deploy information
 */
@interface Deploy:NSObject
@property NSString * itsHash;
@property NSMutableArray * approvals;
@property DeployHeader * header;
@property ExecutableDeployItem * payment;
@property ExecutableDeployItem * session;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Deploy object
 */
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
