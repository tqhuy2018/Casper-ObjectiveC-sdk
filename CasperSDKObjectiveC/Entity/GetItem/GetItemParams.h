#ifndef GetItemParams_h
#define GetItemParams_h
@interface GetItemParams:NSObject
@property NSString * state_root_hash;
@property NSString * key;
@property NSMutableArray * path;
-(NSString *) toJsonString;
@end

#endif 
