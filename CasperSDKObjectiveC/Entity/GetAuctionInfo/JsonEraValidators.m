#import <Foundation/Foundation.h>
#import "JsonEraValidators.h"
#import "JsonValidatorWeights.h"
@implementation JsonEraValidators
+(JsonEraValidators*) fromJsonDictToJsonEraValidators:(NSDictionary*) fromDict{
    JsonEraValidators * ret = [[JsonEraValidators alloc] init];
    ret.era_id = [(NSString*) fromDict[@"era_id"] longLongValue];
    NSArray * listVW = (NSArray*) fromDict[@"validator_weights"];
    int totalVW = (int) listVW.count;
    if(totalVW > 0) {
        ret.validator_weights = [[NSMutableArray alloc] init];
        for(int i = 0 ; i < totalVW; i ++) {
            JsonValidatorWeights * oneVW = [[JsonValidatorWeights alloc] init];
            oneVW = [JsonValidatorWeights fromJsonDictToJsonValidatorWeights:(NSDictionary *)[listVW objectAtIndex:i]];
            [ret.validator_weights addObject: oneVW];
        }
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonEraValidators, era_id:%llu",self.era_id);
    int totalVW = (int) self.validator_weights.count;
    NSLog(@"JsonEraValidators, total JsonValidatorWeights:%i",totalVW);
    if(totalVW>0) {
        NSLog(@"Information for the first JsonValidatorWeight:");
        JsonValidatorWeights * oneVW = (JsonValidatorWeights*) [self.validator_weights objectAtIndex:0];
        [oneVW logInfo];
    }
}
@end
