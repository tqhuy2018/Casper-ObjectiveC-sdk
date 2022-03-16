#import <Foundation/Foundation.h>
#import "CLTypeOption.h"
@implementation CLTypeOption
-(void) logInfo {
    [super logInfo];
    NSLog(@"DONE for Option");
}
-(id)init {
    if ( self = [super init] ) {
        self.itsType = @"Option";
        self.itsTag = @"0d";
        self.innerType1 = [[CLType alloc] init];
        self.is_innerType1_exists = true;
        self.is_innerType2_exists = false;
        self.is_innerType3_exists = false;
    }
    return self;
}
@end
