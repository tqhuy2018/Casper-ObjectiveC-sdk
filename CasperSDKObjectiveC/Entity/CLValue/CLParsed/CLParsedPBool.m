#import <Foundation/Foundation.h>
#import "CLParsedPBool.h"
@implementation CLParsedPBool

-(id)init {
    if ( self = [super init] ) {
        self.is_primitive = true;
        self.itsCLTypeStr = @"Bool";
    }
    return self;
}

-(bool) getItsValue {
    return [self.itsPrimitiveValue boolValue];
}

@end
