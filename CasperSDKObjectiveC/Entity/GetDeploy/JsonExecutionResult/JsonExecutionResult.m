#import <Foundation/Foundation.h>
#import "JsonExecutionResult.h"
@implementation JsonExecutionResult
+(JsonExecutionResult*) fromJsonDictToJsonExecutionResult:(NSDictionary*) fromDict {
    JsonExecutionResult * ret = [[JsonExecutionResult alloc] init];
    ret.block_hash = fromDict[@"block_hash"];
    NSDictionary * result = (NSDictionary*) fromDict[@"result"];
    //Result Success
    if(!(result[@"Success"] == nil)) {
        
    } else { //Result Failure
        
    }
    return ret;
}
@end
