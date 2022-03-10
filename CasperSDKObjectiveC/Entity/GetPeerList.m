#import <Foundation/Foundation.h>
#import "GetPeerList.h"
@implementation GetPeerList
-(NSString*) fromJsonToPeerList:(NSDictionary*) nsData {
    NSLog([nsData objectForKey:@"jsonrpc"]);
    printf("Done");
    return @"";
}
@end
