#ifndef Contract_h
#define Contract_h
@interface Contract : NSObject

@property NSString * contract_package_hash;
@property NSString * contract_wasm_hash;
@property NSMutableArray * entry_points;
@property NSMutableArray * named_keys;
@property NSString * protocol_version;

@end
#endif
