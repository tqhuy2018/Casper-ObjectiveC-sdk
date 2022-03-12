#import <Foundation/Foundation.h>
#import "GetStateRootHash.h"
@implementation GetStateRootHash
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData {
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSString * state_root_hash = [result objectForKey:@"state_root_hash"];
    return state_root_hash;
}

@end
