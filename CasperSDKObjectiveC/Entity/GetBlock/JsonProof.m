#import <Foundation/Foundation.h>
#import "JsonProof.h"

@implementation JsonProof
+(JsonProof*) fromJsonDictToJsonProof:(NSDictionary*) jsonDict {
    JsonProof * ret = [[JsonProof alloc] init];
    ret.signature = jsonDict[@"signature"];
    ret.public_key = jsonDict[@"public_key"];
    return ret;
}
+(NSMutableArray*) fromJsonDictToJsonProofList:(NSArray*) jsonArray {
    NSMutableArray * ret = [[NSMutableArray alloc] init];
    for (id obj in jsonArray) {
        JsonProof * oneProof = [JsonProof fromJsonDictToJsonProof:(NSDictionary*) obj];
        [ret addObject:oneProof];
    }
    return ret;
}
@end
