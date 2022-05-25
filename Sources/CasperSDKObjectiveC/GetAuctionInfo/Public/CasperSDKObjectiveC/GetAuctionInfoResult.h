#ifndef GetAuctionInfoResult_h
#define GetAuctionInfoResult_h
#import "AuctionState.h"
#import <Foundation/Foundation.h>
/**Class built for state_get_auction_info RPC call
 */
@interface GetAuctionInfoResult:NSObject
@property NSString * api_version;
@property AuctionState * auction_state;
///This function get the GetAuctionInfoResult from Json object taken from the POST request of state_get_auction_info RPC call
+(GetAuctionInfoResult*) fromJsonDictToGetAuctionResult:(NSDictionary*) fromDict;
/**This function initiate the process of sending POST request with given parameter in JSON string format
The input jsonString is used to send to server as parameter of the POST request to get the result back
The input jsonString is somehow like this:
 
 {"method" : "state_get_auction_info","id" : 1,"params" : {"block_identifier" : {"Hash" :"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}},"jsonrpc" : "2.0"}
 */
+(void) getAuctionWithParams:(NSString*) jsonString;
///This function log all the information of the GetAuctionInfoResult object
-(void) logInfo;
@end

#endif 
