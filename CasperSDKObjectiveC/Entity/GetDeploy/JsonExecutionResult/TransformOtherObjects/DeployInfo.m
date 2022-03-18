#import <Foundation/Foundation.h>
#import "DeployInfo.h"
@implementation DeployInfo
+(DeployInfo * ) fromJsonDictToDeployInfo:(NSDictionary*) fromDict {
    DeployInfo * ret = [[DeployInfo alloc] init];
    return ret;
}
@end
