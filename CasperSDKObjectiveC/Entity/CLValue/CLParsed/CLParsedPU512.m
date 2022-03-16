#import <Foundation/Foundation.h>
#import "CLParsedPU512.h"

@implementation CLParsedPU512

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = true;
        self.itsCLTypeStr = @"U512";
    }
    return self;
}
@end
