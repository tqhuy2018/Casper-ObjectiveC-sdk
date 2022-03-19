#ifndef Transform_WriteTransfer_h
#define Transform_WriteTransfer_h
#import "Transfer.h"
///The Transfer object is declared in chain_get_block_transfers RPC call
@interface Transform_WriteTransfer:NSObject
@property Transfer * itsTransfer;
+(Transform_WriteTransfer*) fromJsonDictToTransform_WriteTransfer:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
