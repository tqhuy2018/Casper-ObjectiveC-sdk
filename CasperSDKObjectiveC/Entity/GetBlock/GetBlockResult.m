#import <Foundation/Foundation.h>
#import "GetBlockResult.h"
@implementation GetBlockResult
+(GetBlockResult*) fromJsonDictToGetBlockResult:(NSDictionary *) jsonDict {
    GetBlockResult * ret = [[GetBlockResult alloc] init];
    ret.is_block_exists = true;
    
    return ret;
}
-(void) logInfo {
    NSLog(@"GetBlockResult, api_version:%@",self.api_version);
    if (self.is_block_exists) {
        NSLog(@"GetBlockResult, block info:");
        
    } else {
        NSLog(@"GetBlockResult, block does not exist");
    }
}
@end
