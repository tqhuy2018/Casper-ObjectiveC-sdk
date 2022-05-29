#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/RuntimeArgs.h>
#import <CasperSDKObjectiveC/NamedArg.h>
@implementation RuntimeArgs
+(RuntimeArgs*) fromJsonArrayToRuntimeArg:(NSArray*) fromArray {
    RuntimeArgs * ret = [[RuntimeArgs alloc] init];
    ret.listArgs = [[NSMutableArray  alloc] init];
    int totalElement = (int) fromArray.count;
    for(int i = 0 ;i < totalElement ; i++) {
        NamedArg * na = [NamedArg fromJsonArrayToNamedArg:(NSArray*) fromArray[i]];
        [ret.listArgs addObject:na];
    }
    return ret;
}
-(void) logInfo {
    int totalArgs = (int) self.listArgs.count;
    for(int i = 0 ; i < totalArgs ;i ++) {
        NamedArg * oneNA = (NamedArg*) [self.listArgs objectAtIndex:i];
        [oneNA logInfo];
    }
}
+(NSString *) toJsonString: (RuntimeArgs *) fromRA {
    NSString * ret = @"[";
    int totalArgs = (int) fromRA.listArgs.count;
    if (totalArgs > 0) {
        int counter = 0;
        for(int i = 0 ; i < totalArgs ;i ++) {
            NamedArg * oneNA = (NamedArg*) [fromRA.listArgs objectAtIndex:i];
            NSString * oneNAJsonString = [NamedArg toJsonString:oneNA];
            if (counter < totalArgs -1) {
                ret = [[NSString alloc] initWithFormat:@"%@%@,",ret,oneNAJsonString];
            } else {
                ret = [[NSString alloc] initWithFormat:@"%@%@]",ret,oneNAJsonString];
            }
            counter ++;
        }
        ret = [[NSString alloc] initWithFormat:@"\"args\": %@",ret];
        return ret;
    }
    //if list Args empty just return []
    return @"[]";
}
@end
