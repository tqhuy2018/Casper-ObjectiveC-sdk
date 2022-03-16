#import <Foundation/Foundation.h>
#import "CLParsedPString.h"

@implementation CLParsedPString

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = true;
        self.itsCLTypeStr = @"String";
    }
    return self;
}

@end
