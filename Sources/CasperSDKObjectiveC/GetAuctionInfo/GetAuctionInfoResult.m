#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/GetAuctionInfoResult.h>
#import <CasperSDKObjectiveC/ConstValues.h>
#import <CasperSDKObjectiveC/HttpHandler.h>
/**Class built for state_get_auction_info RPC call
 */
@implementation GetAuctionInfoResult
///This function get the GetAuctionInfoResult from Json object taken from the POST request of state_get_auction_info RPC call
+(GetAuctionInfoResult*) fromJsonDictToGetAuctionResult:(NSDictionary*) fromDict {
    GetAuctionInfoResult * ret = [[GetAuctionInfoResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.auction_state = [[AuctionState alloc] init];
    ret.auction_state = [AuctionState fromJsonDictToAuctionState:(NSDictionary *)fromDict[@"auction_state"]];
    return ret;
}
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "state_get_auction_info","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 */
+(void) getAuctionWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_AUCTION_INFO];
}
@end
