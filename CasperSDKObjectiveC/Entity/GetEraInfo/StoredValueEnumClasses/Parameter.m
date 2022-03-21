#import <Foundation/Foundation.h>
#import "Parameter.h"
@implementation Parameter
+(Parameter*) fromJsonDictToParameter:(NSDictionary*) fromDict{
    Parameter * ret = [[Parameter alloc] init];
    ret.name = (NSString*) fromDict[@"name"];
    return ret;
}
-(void) logInfo {
    NSLog(@"Parameter, name:%@",self.name);
   // NSLog(@"Parameter, clType");
    //[self.cl_type logInfo];
}
@end
