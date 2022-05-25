#ifndef PeerEntry_h
#define PeerEntry_h
/**Class for  PeerEntry
 This class contains all the information for a PeerEntry, which include address and nodeID
 */
#import <Foundation/Foundation.h>
@interface PeerEntry:NSObject
@property NSString * address;
@property NSString * nodeID;
///This function build up the PeerEntry object inner value, with given address and nodeID
-(void) setupFromAddress:(NSString*) theAddress andFromID:(NSString *) theID;
@end

#endif 
