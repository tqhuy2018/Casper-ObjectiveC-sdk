#ifndef GetDeployParams_h
#define GetDeployParams_h
@interface GetDeployParams:NSObject
@property NSString * deploy_hash;
-(NSString *) generatePostParam;
@end

#endif
