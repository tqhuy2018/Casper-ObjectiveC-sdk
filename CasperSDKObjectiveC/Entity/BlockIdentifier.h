
#ifndef BlockIdentifier_h
#define BlockIdentifier_h
typedef NS_ENUM(NSInteger,USE_BLOCK_TYPE) {
    USE_BLOCK_HEIGHT = 1,
    USE_BLOCK_HASH = 2,
    USE_NONE = 3
};
@interface BlockIdentifier:NSObject
@property NSString * blockHash;
@property UInt64 blockHeight;
@property USE_BLOCK_TYPE blockType;
-(void) assignBlockHashWithParam:(NSString*) bHash;
-(void) assignBlockHeigthtWithParam:(UInt64) bHeight;
-(NSString*) toJsonStringWithMethodName:(NSString*) methodName;
@end

#endif /* BlockIdentifier_h */
