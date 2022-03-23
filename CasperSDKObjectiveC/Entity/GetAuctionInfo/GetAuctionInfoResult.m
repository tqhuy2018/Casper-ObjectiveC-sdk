#import <Foundation/Foundation.h>
#import "GetAuctionInfoResult.h"
@implementation GetAuctionInfoResult
+(GetAuctionInfoResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict {
    GetAuctionInfoResult * ret = [[GetAuctionInfoResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.auction_state = [[AuctionState alloc] init];
    ret.auction_state = [AuctionState fromJsonDictToAuctionState:(NSDictionary *)fromDict[@"auction_state"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"GetAuctionInfoResult, api_version:%@",self.api_version);
    [self.auction_state  logInfo];
}

@end
