#ifndef Transform_WriteWithdraw_h
#define Transform_WriteWithdraw_h
@interface Transform_WriteWithdraw:NSObject
@property NSMutableArray * UnbondingPurseList;
+(Transform_WriteWithdraw*) fromJsonArrayToTransform_WriteWithdraw:(NSArray*) fromArray;
-(void) logInfo;
@end

#endif
