#import <Foundation/Foundation.h>
#import "GetBalanceResult.h"
@implementation GetBalanceResult
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict {
    GetBalanceResult * ret = [[GetBalanceResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.balance_value = [U512Class fromStrToClass:(NSString *)fromDict[@"balance_value"]];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    return ret;
}
-(void) logInfo {
    NSLog(@"GetBalanceResult, api_version:%@",self.api_version);
    NSLog(@"GetBalanceResult, balance_value:%@",self.balance_value.itsValue);
    NSLog(@"GetBalanceResult, merkle_proof length:%i",(int)self.merkle_proof.length);
}
@end
