#import <Foundation/Foundation.h>
#import "EntryPoint.h"
@implementation EntryPoint
+(EntryPoint*) fromJsonDictToEntryPoint:(NSDictionary*) fromDict{
    EntryPoint * ret = [[EntryPoint alloc] init];
    return ret;
}
-(void) logInfo {
    NSLog(@"Entry Point");
}
@end
