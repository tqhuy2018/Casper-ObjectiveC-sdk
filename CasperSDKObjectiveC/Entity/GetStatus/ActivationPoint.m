#import <Foundation/Foundation.h>
#import "ActivationPoint.h"
@implementation ActivationPoint
-(void) setupWithEraId:(UInt64)eraId {
    self.era_id = eraId;
    self.itsType = 1;
}
-(void) setupWithTimestamp:(NSString *)timeStamp {
    self.timestamp = timeStamp;
    self.itsType = 2;
}
@end
