#import <Foundation/Foundation.h>
#import "JsonValidatorWeights.h"
#import "U512Class.h"
@implementation JsonValidatorWeights
+(JsonValidatorWeights*) fromJsonDictToJsonValidatorWeights:(NSDictionary*) fromDict {
    JsonValidatorWeights * ret = [[JsonValidatorWeights alloc] init];
    ret.public_key = (NSString*) fromDict[@"public_key"];
    ret.weight = [U512Class fromStrToClass:(NSString *)fromDict[@"weight"]];
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonValidatorWeights, public_key:%@",self.public_key);
    NSLog(@"JsonValidatorWeights, weight:%@",self.weight.itsValue);
}
@end
