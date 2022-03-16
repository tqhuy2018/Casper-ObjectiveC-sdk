#import <Foundation/Foundation.h>
#import "CLParsedMap.h"

@implementation CLParsedMap

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = false;
        self.is_innerParsed1_exists = true;
        self.is_innerParsed2_exists = true;
        self.innerParsed1 = [[CLParsed alloc] init];
        self.innerParsed2 = [[CLParsed alloc] init];
        self.itsCLTypeStr = @"Map";
    }
    return self;
}
-(void) logInfo {
    NSLog(@"------Key log info-------");
    [self.innerParsed1 logInfo];
    NSLog(@"-------Value log info-------");
    [self.innerParsed2 logInfo];
}
@end
