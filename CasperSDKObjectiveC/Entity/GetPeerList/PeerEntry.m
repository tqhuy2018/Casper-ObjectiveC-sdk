#import <Foundation/Foundation.h>
#import "PeerEntry.h"

@implementation PeerEntry
-(void) setupFromAddress:(NSString*) theAddress andFromID:(NSString *) theID {
    self.address = theAddress;
    self.nodeID = theID;
}
@end
