#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonValidatorWeights.h>
#import <CasperSDKObjectiveC/U512Class.h>
/**Class built for storing JsonValidatorWeights information
 */
@implementation JsonValidatorWeights
/**Generate a JsonValidatorWeights from dictionary object taken from the JSON back from the server when call RPC method
 */
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
