#import <Foundation/Foundation.h>
#import "GetItemParams.h"
@implementation GetItemParams
-(NSString*) toJsonString {
    NSString * pathStr = @"";
    if(self.path.count>0) {
        int totalPath = (int) self.path.count;
        pathStr = @"[";
        for(int i = 0 ; i < totalPath; i ++) {
            pathStr = [pathStr stringByAppendingString:[NSString stringWithFormat:@"\"%@\"", (NSString *)[self.path objectAtIndex:i]]];
        }
        pathStr = [pathStr stringByAppendingString:@"]"];
    } else {
        pathStr = @"[]";
    }
    NSString * ret =  [[NSString alloc] initWithFormat:@"{\"method\" : \"state_get_item\",\"id\" : 1,\"params\" :{\"state_root_hash\" : \"%@\",\"key\":\"%@\",\"path\":%@},\"jsonrpc\" : \"2.0\"}",self.state_root_hash,self.key,pathStr];
    return ret;
}
@end
