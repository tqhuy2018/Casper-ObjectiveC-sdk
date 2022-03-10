#import <Foundation/Foundation.h>
#import "GetStateRootHash.h"
@implementation GetStateRootHash
-(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData {
    
    NSLog([nsData objectForKey:@"jsonrpc"]);
    printf("Done");
    return @"";
}

@end
