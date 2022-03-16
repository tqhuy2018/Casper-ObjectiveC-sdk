#import <Foundation/Foundation.h>
#import "CLParsedPU64.h"

@implementation CLParsedPU64

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = true;
        self.itsCLTypeStr = @"U64";
    }
    return self;
}
-(UInt64) getItsValue {
    return [self.itsPrimitiveValue longLongValue];
}
@end
