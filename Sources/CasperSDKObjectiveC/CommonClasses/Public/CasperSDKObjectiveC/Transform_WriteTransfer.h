#ifndef Transform_WriteTransfer_h
#define Transform_WriteTransfer_h
#import <CasperSDKObjectiveC/Transfer.h>
#import <Foundation/Foundation.h>
/**Class built for storing Transform_WriteTransfer information. This class store Transform enum of type  WriteTransfer. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
///The Transfer object is declared in chain_get_block_transfers RPC call
@interface Transform_WriteTransfer:NSObject
@property Transfer * itsTransfer;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transform_WriteTransfer object
 */
+(Transform_WriteTransfer*) fromJsonDictToTransform_WriteTransfer:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
