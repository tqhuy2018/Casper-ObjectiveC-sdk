#import <Foundation/Foundation.h>
#import "JsonBlock.h"
#import "JsonBlockHeader.h"
#import "JsonBlockBody.h"
#import "JsonProof.h"
@implementation JsonBlock
+(JsonBlock*) fromJsonDictToJsonBlock:(NSDictionary*) fromDict {
    JsonBlock * ret = [[JsonBlock alloc] init];
    ret.blockHash = fromDict[@"hash"];
    ret.header = [JsonBlockHeader fromJsonDictToJsonBlockHeader:fromDict[@"header"]];
    ret.body = [JsonBlockBody fromJsonDictToJsonBlockBody:fromDict[@"body"]];
    ret.proofs = [JsonProof fromJsonDictToJsonProofList:(NSArray*) fromDict[@"proofs"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonBlock, block_hash:%@",self.blockHash);
    [self.header logInfo];
}
@end
