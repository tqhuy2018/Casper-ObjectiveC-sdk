#import <Foundation/Foundation.h>
#import "CLTypeList.h"
@implementation CLTypeList
-(void) logInfo {
    [super logInfo];
    NSLog(@"DONE for LIST");
}
-(id)init {
    if ( self = [super init] ) {
        self.itsType = @"List";
        self.itsTag = @"0e";
        self.is_innerType1_exists = true;
        self.is_innerType2_exists = false;
        self.is_innerType3_exists = false;
        self.innerType1 = [[CLType alloc] init];
    }
    return self;
}
@end
