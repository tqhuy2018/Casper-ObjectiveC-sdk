#ifndef ActivationPoint_h
#define ActivationPoint_h
@interface ActivationPoint : NSObject
@property UInt64 era_id;
@property NSString * timestamp;
@property NSInteger itsType;//1 for enum of eraId type, 2 for enum of timestamp type
-(void) setupWithEraId:(UInt64) eraId;
-(void) setupWithTimestamp:(NSString*) timeStamp;
@end

#endif 
