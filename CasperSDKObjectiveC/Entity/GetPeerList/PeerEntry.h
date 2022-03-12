#ifndef PeerEntry_h
#define PeerEntry_h
@interface PeerEntry:NSObject
@property NSString * address;
@property NSString * nodeID;
-(void) setupFromAddress:(NSString*) theAddress andFromID:(NSString *) theID;
@end

#endif 
