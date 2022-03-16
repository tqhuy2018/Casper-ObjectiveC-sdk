#import <Foundation/Foundation.h>
#import "JsonExecutionResult.h"
@implementation JsonExecutionResult
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict {
    JsonExecutionResult * ret = [[JsonExecutionResult alloc] init];
    return ret;
}
@end
