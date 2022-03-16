#import <Foundation/Foundation.h>
#import "CLType.h"
@implementation CLType
-(void) logInfo {
    NSLog(@"CLType is %@",_itsType);
    if (self.is_innerType1_exists) {
        [self.innerType1 logInfo];
    }
    if (self.is_innerType2_exists) {
        [self.innerType1 logInfo];
    }
    if (self.is_innerType3_exists) {
        [self.innerType3 logInfo];
    }
}
-(id)init {
    if ( self = [super init] ) {
       
    }
    return self;
}

@end
