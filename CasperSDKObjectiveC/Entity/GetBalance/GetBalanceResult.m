#import <Foundation/Foundation.h>
#import "GetBalanceResult.h"
#import "ConstValues.h"
#import "HttpHandler.h"
@implementation GetBalanceResult
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict {
    GetBalanceResult * ret = [[GetBalanceResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.balance_value = [U512Class fromStrToClass:(NSString *)fromDict[@"balance_value"]];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    return ret;
}
+(void) getBalanceWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_BALANCE];
}
-(void) logInfo {
    NSLog(@"GetBalanceResult, api_version:%@",self.api_version);
    NSLog(@"GetBalanceResult, balance_value:%@",self.balance_value.itsValue);
    NSLog(@"GetBalanceResult, merkle_proof length:%i",(int)self.merkle_proof.length);
}
@end
