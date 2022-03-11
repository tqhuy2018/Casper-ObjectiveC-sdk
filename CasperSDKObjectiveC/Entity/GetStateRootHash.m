#import <Foundation/Foundation.h>
#import "GetStateRootHash.h"
@implementation GetStateRootHash
-(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData {
    NSDictionary * result = [nsData objectForKey:@"result"];
    NSString * state_root_hash = [result objectForKey:@"state_root_hash"];
    NSLog(@"State_Root_Hash:%@",state_root_hash);
    //printf(@"Done");
    return state_root_hash;
}

@end
