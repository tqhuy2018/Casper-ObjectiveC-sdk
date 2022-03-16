#import <Foundation/Foundation.h>
#import "CLParsedPU256.h"

@implementation CLParsedPU256

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = true;
        self.itsCLTypeStr = @"U256";
    }
    return self;
}
@end
