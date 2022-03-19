#import <Foundation/Foundation.h>
#import "NamedKey.h"
@implementation NamedKey
+(NamedKey*) fromJsonDictToNamedKey:(NSDictionary*) fromDict {
    NamedKey * ret = [[NamedKey alloc] init];
    ret.key = (NSString*) fromDict[@"key"];
    ret.name = (NSString*) fromDict[@"name"];
    return ret;
}
-(void) logInfo {
    NSLog(@"NamedKey key:%@",self.key);
    NSLog(@"NamedKey name:%@",self.name);
}
@end
