#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonEraValidators.h>
#import <CasperSDKObjectiveC/JsonValidatorWeights.h>
/**Class built for storing JsonEraValidators information
 */
@implementation JsonEraValidators
/**Generate a JsonEraValidators from dictionary object taken from the JSON back from the server when call RPC method
 */
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
