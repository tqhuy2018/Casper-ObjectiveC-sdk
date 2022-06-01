#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonEraEnd.h>
#import <CasperSDKObjectiveC/ValidatorWeight.h>
#import <CasperSDKObjectiveC/JsonEraReport.h>
/**Class built for storing JsonEraEnd information
 */
@implementation JsonEraEnd
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonEraEnd object
 */
+(JsonEraEnd*) fromJsonDictToJsonEraEnd:(NSDictionary*) fromDict {
    JsonEraEnd * ret = [[JsonEraEnd alloc] init];
    if(![fromDict[@"next_era_validator_weights"] isEqual:[NSNull null]]) {
        ret.next_era_validator_weights = [[NSMutableArray alloc] init];
        NSArray * listValidatorWeight = (NSArray*) fromDict[@"next_era_validator_weights"];
        for(id obj in listValidatorWeight) {
            ValidatorWeight * oneVW = [[ValidatorWeight alloc] init];
            oneVW.validator = obj[@"validator"];
            oneVW.weight = [U512Class fromStrToClass:obj[@"weight"]];
            [ret.next_era_validator_weights addObject:oneVW];
        }
    }
    if(![fromDict[@"era_report"] isEqual:[NSNull null]]) {
        ret.era_report = [JsonEraReport fromJsonDictToJsonEraReport:fromDict[@"era_report"]];
    }
    return ret;
}
@end
