#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Approval.h>
@implementation Approval
+(NSMutableArray*) fromArrayToListApproval:(NSArray*) fromArray {
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    int totalElement = (int) fromArray.count;
    for(int i = 0 ; i < totalElement; i++) {
        NSDictionary * oneElementDict = (NSDictionary*) [fromArray objectAtIndex:i];
        Approval * oneA = [Approval fromJsonDictToApproval:oneElementDict];
        [ret addObject:oneA];
    }
    return ret;
}

+(Approval*) fromJsonDictToApproval:(NSDictionary*) fromDict {
    Approval * ret = [[Approval alloc] init];
    ret.signature = (NSString*) fromDict[@"signature"];
    ret.signer = (NSString*) fromDict[@"signer"];
    return ret;
}

@end
