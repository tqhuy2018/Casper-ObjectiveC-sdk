#import <Foundation/Foundation.h>
#import "CasperSDK.h"
#import "HttpHandler.h"
@implementation CasperSDK
-(NSString*) getStateRootHash:(NSString *)params {
    HttpHandler * httpHandler = [[HttpHandler alloc] init];
    [httpHandler handleRequestWithParam:@""];
    return @"state_root_hash";
}

@end
