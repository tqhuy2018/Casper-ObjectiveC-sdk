#import <Foundation/Foundation.h>
#import "EntryPointAccess.h"
#import "Groups.h"
@implementation EntryPointAccess
+(EntryPointAccess*) fromJsonDictToEntryPointAccess:(NSDictionary*) fromDict {
    EntryPointAccess * ret = [[EntryPointAccess alloc] init];
    //check if type is Public
    if(!(fromDict[@"Public"] == nil)) {
        ret.is_type_public = true;
    } else { //else type is of Groups - list of Group
        ret.is_type_public = false;
        Groups * groups = [[Groups alloc] init];
        NSArray * listGroup = (NSArray*) fromDict[@"Groups"];
        int totalGroup = (int) listGroup.count;
        if(totalGroup>0) {
            ret.Groups = [[NSMutableArray alloc] init];
            for(int i = 0; i < totalGroup;i++) {
                NSString * oneGroupStr = (NSString*) [listGroup objectAtIndex:i];
                [ret.Groups addObject:oneGroupStr];
            }
        }
    }
    return ret;
}
-(void) logInfo {
    
}
@end
