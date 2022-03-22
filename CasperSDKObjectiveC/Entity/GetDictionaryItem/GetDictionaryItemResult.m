#import <Foundation/Foundation.h>
#import "GetDictionaryItemResult.h"
@implementation GetDictionaryItemResult
+(GetDictionaryItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict {
    GetDictionaryItemResult * ret = [[GetDictionaryItemResult alloc] init];
    ret.api_version = (NSString* ) fromDict[@"api_version"];
    ret.dictionary_key = (NSString*) fromDict[@"dictionary_key"];
    ret.merkle_proof = (NSString *) fromDict[@"merkle_proof"];
    ret.stored_value = [StoredValue fromJsonDictToStoredValue:(NSDictionary*) fromDict[@"stored_value"]];
    return ret;
}
-(void)logInfo {
    NSLog(@"GetDictionaryItemResult, api_version:%@",self.api_version);
    NSLog(@"GetDictionaryItemResult, dictionary_key:%@",self.dictionary_key);
    NSLog(@"GetDictionaryItemResult, merkle_proof length:%i",(int)self.merkle_proof.length);
    NSLog(@"GetDictionaryItemResult,StoredValue information");
    [self.stored_value logInfo];
    
}
@end
