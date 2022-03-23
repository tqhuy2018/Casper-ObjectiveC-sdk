#ifndef GetStateRootHash_h
#define GetStateRootHash_h
@interface GetStateRootHash:NSObject
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData;
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString;
@end

#endif
