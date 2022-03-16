#import <Foundation/Foundation.h>
#import "CLParsed.h"

@implementation CLParsed
+(CLParsed*) fromJsonToCLParsed:(NSDictionary*) fromDict {
    CLParsed * ret = [[CLParsed alloc] init];
    return ret;
}
-(void) logInfo {
    if (self.is_primitive == true) {
        NSLog(@"Value of parsed:%@",self.itsPrimitiveValue);
    } else if(self.is_array_type == true){
        NSInteger totalValue = [self.arrayValue count];
        for(int i = 0 ; i < totalValue;i ++) {
            CLParsed * oneParsed = [self.arrayValue objectAtIndex:i];
            //NSLog(@"inner type string:%@",oneParsed.itsCLTypeStr);
            [oneParsed logInfo];
            //NSLog(@"Value of parsed number %d is:%@",i,[self.arrayValue objectAtIndex:i]);
        }
    } 
}
-(id)init {
    if ( self = [super init] ) {
        self.is_innerParsed1_exists = false;
        self.is_innerParsed2_exists = false;
        self.is_innerParsed3_exists = false;
    }
    return self;
}

@end
