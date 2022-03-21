#import <Foundation/Foundation.h>
#import "StoredValue.h"
#import "EraInfo.h"
#import "ConstValues.h"
@implementation StoredValue

+(StoredValue *) fromJsonDictToStoredValue:(NSDictionary*) fromDict{
    StoredValue * ret = [[StoredValue alloc] init];
    if(!(fromDict[@"EraInfo"] == nil)) {
        ret.itsType = @"EraInfo";
        EraInfo * era = [[EraInfo alloc] init];
        NSDictionary * SADict = (NSDictionary*) fromDict[@"EraInfo"];
        NSArray * listSA = (NSArray*) SADict[@"seigniorage_allocations"];
        era = [EraInfo fromJsonArrayToEraInfo:listSA];
        ret.innerValue = [[NSMutableArray alloc] init];
        [ret.innerValue addObject:era];
    }
    return ret;
}

-(void) logInfo {
    NSLog(@"StoredValue log info, type:%@",self.itsType);
    if ([self.itsType isEqualToString: @"EraInfo"]) {
        EraInfo * era = (EraInfo*)[self.innerValue objectAtIndex:0];
        [era logInfo];
    }
}

@end
