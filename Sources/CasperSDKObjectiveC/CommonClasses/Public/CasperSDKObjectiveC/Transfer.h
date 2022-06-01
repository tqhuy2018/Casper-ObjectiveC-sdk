#import "U512Class.h"
#import <Foundation/Foundation.h>
#ifndef Transfer_h
#define Transfer_h
/**Class built for storing Transfer information
 */
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
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Transfer object
 */
+(Transfer*) fromJsonDictToTransfer:(NSDictionary*) jsonDict;
/**This function parse the Array object (as part of the JSON object taken from server RPC method call) to a list of Transfer object
 */
+(NSMutableArray*) fromJsonDictToTransferList:(NSArray*) nsArray;
@end
#endif
