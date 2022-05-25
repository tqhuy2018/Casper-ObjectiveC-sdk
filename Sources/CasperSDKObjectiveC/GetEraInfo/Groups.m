#import <Foundation/Foundation.h>
#import <CasperSDKObjectiveC/Groups.h>
/**Class built for storing Groups information
 */
@implementation Groups
/**This function parse the Dictionary object (as part of the JSON object taken from server RPC method call) to Groups object
 */
+(Groups*) fromJSonDictToGroups:(NSDictionary*) fromDict {
    Groups * ret = [[Groups alloc] init];
    ret.group = fromDict[@"group"];
    NSArray * listKey = fromDict[@"keys"];
    int totalKey = (int) listKey.count;
    if(totalKey>0) {
        ret.keys = [[NSMutableArray alloc] init];
        for (int i = 0; i<totalKey; i++) {
            NSString * oneKey = (NSString*) [listKey objectAtIndex:i];
            [ret.keys addObject:oneKey];
        }
    }
    return ret;
}
-(void) logInfo {
    NSLog(@"Groups, group:%@",self.group);
    int totalKey = (int) self.keys.count;
    NSLog(@"Groups, total keys:%i",totalKey);
    if(totalKey >0) {
        NSLog(@"Groups first key information");
        NSString * oneKey = (NSString*) [self.keys objectAtIndex:0];
        NSLog(@"Groups, key 0 is:%@",oneKey);
    }
}

@end
