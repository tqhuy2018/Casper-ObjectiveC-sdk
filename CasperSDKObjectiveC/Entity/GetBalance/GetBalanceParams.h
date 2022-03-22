#ifndef GetBalanceParams_h
#define GetBalanceParams_h
@interface GetBalanceParams:NSObject
@property NSString * state_root_hash;
@property NSString * purse_uref;
-(NSString*) toJsonString;
@end

#endif 
