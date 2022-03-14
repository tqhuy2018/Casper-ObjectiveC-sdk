#import "U512Class.h"

#ifndef Transfer_h
#define Transfer_h

@interface Transfer:NSObject

@property NSString * deploy_hash;
@property NSString * from;
@property NSString * to;//optional
@property NSString * source;
@property NSString * target;
@property U512Class * amount;
@property U512Class * gas;
@property UInt64 id;//optional
@property bool is_to_exists;
@property bool is_id_exists;
+(Transfer*) fromJsonDictToTransfer:(NSDictionary*) jsonDict;
+(NSMutableArray*) fromJsonDictToTransferList:(NSArray*) nsArray;
-(void) logInfo;
@end
#endif
