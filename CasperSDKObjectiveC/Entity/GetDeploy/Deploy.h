#ifndef Deploy_h
#define Deploy_h
#import "DeployHeader.h"
@interface Deploy:NSObject
@property NSString * itsHash;
@property NSMutableArray * approvals;
@property DeployHeader * header;
+(Deploy*) fromJsonDictToDeploy:(NSDictionary*) fromDict;
@end

#endif
