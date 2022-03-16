#import <Foundation/Foundation.h>
#import "CLTypeMap.h"
@implementation CLTypeMap
-(void) logInfo {
    [super logInfo];
    NSLog(@"DONE for Map");
}
-(id)init {
    if ( self = [super init] ) {
        self.itsType = @"Map";
        self.itsTag = @"11";
        self.innerType1 = [[CLType alloc] init];
        self.innerType2 = [[CLType alloc] init];
        self.is_innerType1_exists = true;
        self.is_innerType2_exists = true;
        self.is_innerType3_exists = false;
    }
    return self;
}
@end
