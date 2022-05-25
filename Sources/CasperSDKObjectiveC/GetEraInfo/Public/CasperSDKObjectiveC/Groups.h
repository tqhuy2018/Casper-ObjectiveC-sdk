#ifndef Groups_h
#define Groups_h
/**Class built for storing Groups information
 */
#import <Foundation/Foundation.h>
@interface Groups:NSObject
@property NSString * group;
///List of Key of type URef
@property NSMutableArray * keys;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Groups object
 */
+(Groups*) fromJSonDictToGroups:(NSDictionary*) fromDict;
-(void) logInfo;
@end

#endif
