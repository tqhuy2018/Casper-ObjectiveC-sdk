#import <Foundation/Foundation.h>
#import "GetItemResult.h"
#import "ConstValues.h"
#import "HttpHandler.h"
@implementation GetItemResult

+(GetItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict{
    GetItemResult * ret = [[GetItemResult alloc] init];
    ret.api_version = (NSString*) fromDict[@"api_version"];
    ret.merkle_proof = (NSString*) fromDict[@"merkle_proof"];
    ret.stored_value = [StoredValue fromJsonDictToStoredValue:(NSDictionary *)fromDict[@"stored_value"]];
    return ret;
}
+(void) getItemWithParams:(NSString*) jsonString {
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_STATE_GET_ITEM];
}
-(void)logInfo {
    NSLog(@"GetItemResult, api_version:%@",self.api_version);
    NSLog(@"GetItemResult, merkle_proof length:%i",(int)self.merkle_proof.length);
    NSLog(@"GetItemResult, stored_value information");
    [self.stored_value logInfo];
}
@end
