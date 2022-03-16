#import <Foundation/Foundation.h>
#import "CLParsedList.h"
@implementation CLParsedList

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = false;
        self.is_array_type = true;
        self.arrayValue = [[NSMutableArray alloc] init];
        self.itsCLTypeStr = @"List";
    }
    return self;
}

@end
