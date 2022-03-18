#ifndef TransformEntry_h
#define TransformEntry_h
@interface TransformEntry:NSObject
@property NSString * key;
///Transform of type enum, but saved as 1 array of 1 element only. The value of the element is determined at parsing time to see what kind of Transform it is to put in the array;
@property NSArray * transform;
+(TransformEntry*) fromJsonDictToTransformEntry:(NSDictionary*) fromDict;
@end

#endif
