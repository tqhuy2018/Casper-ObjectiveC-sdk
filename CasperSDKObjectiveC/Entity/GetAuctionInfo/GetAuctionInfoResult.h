#ifndef GetAuctionInfoResult_h
#define GetAuctionInfoResult_h
#import "AuctionState.h"
@interface GetAuctionInfoResult:NSObject
@property NSString * api_version;
@property AuctionState * auction_state;
+(GetAuctionInfoResult*) fromJsonDictToGetAuctionResult:(NSDictionary*) fromDict;
+(void) getAuctionWithParams:(NSString*) jsonString;
-(void) logInfo;
@end

#endif 
