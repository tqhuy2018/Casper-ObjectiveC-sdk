#ifndef Deploy_h
#define Deploy_h
#import "DeployHeader.h"
#import "ExecutableDeployItem.h"
@interface Deploy:NSObject
@property NSString * itsHash;
@property NSMutableArray * approvals;
@property DeployHeader * header;
@property ExecutableDeployItem * payment;
@property ExecutableDeployItem * session;
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
