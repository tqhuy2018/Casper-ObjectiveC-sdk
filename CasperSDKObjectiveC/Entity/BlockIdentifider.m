#import <Foundation/Foundation.h>
#import "BlockIdentifier.h"

@implementation BlockIdentifier
    -(void) assignBlockHashWithParam:(NSString*) bHash{
        self.blockHash = bHash;
    }
    -(void) assignBlockHeigthtWithParam:(UInt32) bHeight {
        self.blockHeight = bHeight;
    }
@end
