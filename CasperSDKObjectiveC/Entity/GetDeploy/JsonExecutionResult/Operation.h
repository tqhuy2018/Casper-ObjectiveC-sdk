#ifndef Operation_h
#define Operation_h
/**Class built for storing Operation information
 */
@interface Operation:NSObject
@property NSString * key;
///Value of type enum OpKind, which can be among 1 of the 4 possible values:
///Read,Write,Add,NoOp
///Saved as String of 4 possible corresponding values: Read,Write,Add,NoOp,
@property NSString * kind;

@end

#endif
