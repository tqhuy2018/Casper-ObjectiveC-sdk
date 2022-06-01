#ifndef NamedKey_h
#define NamedKey_h
#import <Foundation/Foundation.h>
/**Class built for storing NamedKey information.
 */
@interface NamedKey:NSObject
@property NSString * name;
@property NSString * key;
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to NamedKey object
 */
+(NamedKey*) fromJsonDictToNamedKey:(NSDictionary*) fromDict;
@end

#endif
