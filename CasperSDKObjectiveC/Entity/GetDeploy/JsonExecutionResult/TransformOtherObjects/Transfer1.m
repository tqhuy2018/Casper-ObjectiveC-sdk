/*#import <Foundation/Foundation.h>
#import "Transfer.h"
@implementation Transfer
+(Transfer*) fromJsonDictToTransfer:(NSDictionary*) fromDict {
    Transfer * ret = [[Transfer alloc] init];
    ret.deploy_hash = (NSString *) fromDict[@"deploy_hash"];
    ret.from = (NSString*) fromDict[@"from"];
    if(!(fromDict[@"to"] == nil)) {
        ret.to = (NSString*) fromDict[@"to"];
        ret.is_to_exists = true;
    }
    return ret;
}
-(void)logInfo {
    
}

@end*/
