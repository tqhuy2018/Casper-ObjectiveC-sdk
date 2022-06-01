#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/AuctionState.h>
#import <CasperSDKObjectiveC/JsonEraValidators.h>
/**Class built for storing AuctionState information
 */
@implementation AuctionState
+(AuctionState*) fromJsonDictToAuctionState:(NSDictionary*) fromDict {
    AuctionState * ret = [[AuctionState alloc] init];
    ret.state_root_hash = (NSString*) fromDict[@"state_root_hash"];
    ret.block_height = [(NSString*) fromDict[@"block_height"] longLongValue];
    NSArray * listEV = (NSArray*) fromDict[@"era_validators"];
    int totalEV = (int) listEV.count;
    if(totalEV > 0) {
        ret.era_validators = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalEV; i ++) {
            NSDictionary * oneEVDict = (NSDictionary *) [listEV objectAtIndex:i];
            JsonEraValidators * oneEV = [[JsonEraValidators alloc] init];
            oneEV = [JsonEraValidators fromJsonDictToJsonEraValidators:oneEVDict];
            [ret.era_validators addObject:oneEV];
        }
    }
    return ret;
}
@end
