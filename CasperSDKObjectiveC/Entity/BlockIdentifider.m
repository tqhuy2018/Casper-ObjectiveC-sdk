#import <Foundation/Foundation.h>
#import "BlockIdentifier.h"

@implementation BlockIdentifier
    -(void) assignBlockHashWithParam:(NSString*) bHash{
        self.blockHash = bHash;
    }
    -(void) assignBlockHeigthtWithParam:(UInt64) bHeight {
        self.blockHeight = bHeight;
    }
-(NSString*) toJsonStringWithMethodName:(NSString*) methodName {
    NSString * retJsonStr = @"";
    if(self.blockType == USE_BLOCK_HASH) {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" : {\"block_identifier\" : {\"Hash\" :\"%@\"}},\"jsonrpc\" : \"2.0\"}",methodName,self.blockHash];
    } else if (self.blockType == USE_BLOCK_HEIGHT) {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" : {\"block_identifier\" : {\"Height\" :%llu}},\"jsonrpc\" : \"2.0\"}",methodName,self.blockHeight];
    } else {
        retJsonStr = [[NSString alloc] initWithFormat:@"{\"method\" : \"%@\",\"id\" : 1,\"params\" :\"[]\",\"jsonrpc\" : \"2.0\"}",methodName];
    }
    return retJsonStr;
}
@end
