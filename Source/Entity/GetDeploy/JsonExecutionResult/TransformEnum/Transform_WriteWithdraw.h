#ifndef Transform_WriteWithdraw_h
#define Transform_WriteWithdraw_h
/**Class built for storing Transform_WriteWithdraw information. This class store Transform enum of type  WriteWithdraw. The Transform enum is based on this address:
 https://docs.rs/casper-types/1.4.6/casper_types/enum.Transform.html
 */
@interface Transform_WriteWithdraw:NSObject
@property NSMutableArray * UnbondingPurseList;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to Transform_WriteWithdraw object
 */
+(Transform_WriteWithdraw*) fromJsonArrayToTransform_WriteWithdraw:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
