#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/PeerEntry.h>
/**Class for  PeerEntry
 This class contains all the information for a PeerEntry, which include address and nodeID
 */
@implementation PeerEntry
///This function build up the PeerEntry object inner value, with given address and nodeID
-(void) setupFromAddress:(NSString*) theAddress andFromID:(NSString *) theID {
    self.address = theAddress;
    self.nodeID = theID;
}
@end
