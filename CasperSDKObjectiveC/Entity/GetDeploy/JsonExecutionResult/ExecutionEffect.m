#import <Foundation/Foundation.h>
#import "ExecutionEffect.h"
@implementation ExecutionEffect
+(ExecutionEffect*) fromJsonDictToExecutionEffect:(NSDictionary*) fromDict {
    ExecutionEffect * ret = [[ExecutionEffect alloc] init];
    return ret;
}
@end
