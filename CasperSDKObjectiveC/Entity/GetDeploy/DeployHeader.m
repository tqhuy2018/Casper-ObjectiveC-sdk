#import <Foundation/Foundation.h>
#import "DeployHeader.h"
@implementation DeployHeader
+(DeployHeader*) fromJsonDictToDeployHeader:(NSDictionary*) fromDict {
    DeployHeader * ret = [[DeployHeader alloc] init];
    ret.account = fromDict[@"account"];
    ret.body_hash = fromDict[@"body_hash"];
    ret.chain_name = fromDict[@"chain_name"];
    if (![fromDict[@"dependencies"] isEqual:[NSNull null]]) {
        
        NSArray * array = (NSArray*) fromDict[@"dependencies"];
        if (array.count > 0) {
            NSMutableArray * d = [[NSMutableArray alloc] init];
            int totalElement = (int) array.count;
            for(int i = 0 ; i < totalElement ; i ++) {
                [d addObject:[array objectAtIndex:i]];
            }
            ret.dependencies = [[NSMutableArray alloc]init];
            ret.dependencies = d;
        }
    }
    ret.gas_price = [fromDict[@"gas_price"] longLongValue];
    ret.timestamp = fromDict[@"timestamp"];
    ret.ttl = fromDict[@"ttl"];
    return ret;
}
-(void) logInfo{
    NSLog(@"Deploy header, account:%@",self.account);
    NSLog(@"Deploy header, body_hash:%@",self.body_hash);
    NSLog(@"Deploy header, chain_name:%@",self.chain_name);
    NSLog(@"Deploy header, dependencies size:%lu",(unsigned long) self.dependencies.count);
    if(self.dependencies.count >0 ) {
        NSLog(@"Deploy header, first dependency:%@",(NSString*) self.dependencies.firstObject);
    }
    NSLog(@"Deploy header, gas_price:%llu",self.gas_price);
    NSLog(@"Deploy header, timestamp:%@",self.timestamp);
    NSLog(@"Deploy header, ttl:%@",self.ttl);
}
@end
