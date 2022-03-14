#import <Foundation/Foundation.h>
#import "JsonEraReport.h"
#import "Reward.h"
@implementation JsonEraReport
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
            oneReward.amount = (UInt64) obj[@"amount"];
            oneReward.validator = (NSString*) obj[@"validator"];
            [ret.rewards addObject:oneReward];
        }
    }
    return ret;
}
@end
