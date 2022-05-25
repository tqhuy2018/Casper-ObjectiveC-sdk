#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/JsonEraReport.h>
#import <CasperSDKObjectiveC/Reward.h>
#import <CasperSDKObjectiveC/Utils.h>
/**Class built for storing JsonEraReport information
 */
@implementation JsonEraReport
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to JsonEraReport object
 */
+(JsonEraReport*) fromJsonDictToJsonEraReport:(NSDictionary *) fromDict {
    JsonEraReport * ret = [[JsonEraReport alloc] init];
    if(![fromDict[@"equivocators"] isEqual:[NSNull null]]) {
        ret.equivocators = [[NSMutableArray alloc] init];
        NSArray * listEquivocators = (NSArray*) fromDict[@"equivocators"];
        for(id obj in listEquivocators) {
            [ret.equivocators addObject:(NSString*) obj];
        }
    }
    if(![fromDict[@"inactive_validators"] isEqual:[NSNull null]]) {
        ret.inactive_validators = [[NSMutableArray alloc] init];
        NSArray * listInactiveValidator = (NSArray*) fromDict[@"inactive_validators"];
        for (id obj in listInactiveValidator) {
            [ret.inactive_validators addObject:(NSString*) obj];
        }
    }
    if(![fromDict[@"rewards"] isEqual: [NSNull null]]) {
        ret.rewards = [[NSMutableArray alloc] init];
        NSArray * listReward = (NSArray*) fromDict[@"rewards"];
        for(id obj in listReward) {
            Reward * oneReward = [[Reward alloc] init];
            NSString * amountStr = obj[@"amount"];
            oneReward.amount = [amountStr longLongValue];
            oneReward.validator = (NSString*) obj[@"validator"];
            [ret.rewards addObject:oneReward];
        }
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"JsonEraReport,total equivocators:%lu",(unsigned long) self.equivocators.count);
    NSLog(@"JsonEraReport,total inactive_validators:%lu",(unsigned long) self.inactive_validators.count);
    NSLog(@"JsonEraReport,total reward:%lu",(unsigned long) self.rewards.count);
    if(self.equivocators.count > 0) {
        NSLog(@"JsonEraReport, first equivocator: %@",(NSString*) self.equivocators.firstObject);
    }
    if(self.inactive_validators.count > 0) {
        NSLog(@"JsonEraReport, first inactive_validator:%@",(NSString*) self.inactive_validators.firstObject);
    }
    if(self.rewards.count>0) {
        Reward * fr = [[Reward alloc] init];
        fr = self.rewards.firstObject;
        NSLog(@"JsonEraReport, first reward validator:%@",fr.validator);
        NSLog(@"JsonEraReport, first reward amount:%llu",fr.amount);
    }
}
@end
