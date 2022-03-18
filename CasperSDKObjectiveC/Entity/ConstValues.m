#import <Foundation/Foundation.h>
#import "ConstValues.h"
NSString *const CASPER_ERROR_MESSAGE_NONE = @"NONE";
NSString *const CASPER_RPC_METHOD_GET_STATE_ROOT_HASH = @"chain_get_state_root_hash";
NSString *const CASPER_RPC_METHOD_INFO_GET_PEERS = @"info_get_peers";
NSString *const CASPER_RPC_METHOD_INFO_GET_DEPLOY = @"info_get_deploy";
NSString *const CASPER_RPC_METHOD_INFO_GET_STATUS = @"info_get_status";
NSString *const CASPER_RPC_METHOD_CHAIN_GET_BLOCK_TRANSFERS = @"chain_get_block_transfers";
NSString *const CASPER_RPC_METHOD_CHAIN_GET_BLOCK = @"chain_get_block";
NSString *const CASPER_RPC_METHOD_CHAIN_GET_ERA_BY_SWITCH_BLOCK = @"chain_get_era_info_by_switch_block";
NSString *const CASPER_RPC_METHOD_STATE_GET_ITEM = @"state_get_item";
NSString *const CASPER_RPC_METHOD_STATE_GET_DICTIONARY_ITEM = @"state_get_dictionary_item";
NSString *const CASPER_RPC_METHOD_STATE_GET_BALANCE = @"state_get_balance";
NSString *const CASPER_RPC_METHOD_STATE_GET_AUCTION_INFO = @"state_get_auction_info";
NSString *const CASPER_RPC_METHOD_ACCOUNT_PUT_DEPLOY = @"put_deploy";

//CLType
 NSString *const CLTYPE_BOOL            = @"bool";
 NSString *const CLTYPE_I32             = @"I32";
 NSString *const CLTYPE_I64             = @"I64";
 NSString *const CLTYPE_U8              = @"U8";
 NSString *const CLTYPE_U32             = @"U32";
 NSString *const CLTYPE_U64             = @"U64";
 NSString *const CLTYPE_U128            = @"U128";
 NSString *const CLTYPE_U256            = @"U256";
 NSString *const CLTYPE_U512            = @"U512";
 NSString *const CLTYPE_UNIT            = @"Unit";
 NSString *const CLTYPE_STRING          = @"String";
 NSString *const CLTYPE_KEY             = @"Key";
 NSString *const CLTYPE_UREF            = @"URef";
 NSString *const CLTYPE_PUBLICKEY       = @"PublicKey";
 NSString *const CLTYPE_OPTION          = @"Option";
 NSString *const CLTYPE_LIST            = @"List";
NSString *const CLTYPE_LIST_MAP_KEY     = @"ListMapKey";
NSString *const CLTYPE_LIST_MAP_VALUE   = @"ListMapValue";
 NSString *const CLTYPE_BYTEARRAY       = @"ByteArray";
 NSString *const CLTYPE_RESULT          = @"Result";
 NSString *const CLTYPE_MAP             = @"Map";
 NSString *const CLTYPE_TUPLE1          = @"Tuple1";
 NSString *const CLTYPE_TUPLE2          = @"Tuple2";
 NSString *const CLTYPE_TUPLE3          = @"Tuple3";
 NSString *const CLTYPE_ANY             = @"Any";
NSString *const CLTYPE_NULL_VALUE       = @"NULL";

//ExecutableDeployItem

NSString *const EDI_MODULEBYTES                         = @"ModuleBytes";
NSString *const EDI_STORED_CONTRACT_BY_HASH             = @"StoredContractByHash";
NSString *const EDI_STORED_CONTRACT_BY_NAME             = @"StoredContractByName";
NSString *const EDI_STORED_VERSIONED_CONTRACT_BY_HASH   = @"StoredVersionedContractByHash";
NSString *const EDI_STORED_VERSIONED_CONTRACT_BY_NAME   = @"StoredVersionedContractByName";
NSString *const EDI_TRANSFER                            = @"Transfer";

//Transform
NSString *const TRANSFORM_IDENTITY                  = @"TransformIdentity";
NSString *const TRANSFORM_WRITE_CLVALUE             = @"TransformWriteCLValue";
NSString *const TRANSFORM_WRITE_ACCOUNT             = @"TransformWriteAccount";
NSString *const TRANSFORM_WRITE_CONTRACT_WASM       = @"TransformWriteContractWasm";
NSString *const TRANSFORM_WRITE_CONTRACT            = @"TransformWriteContract";
NSString *const TRANSFORM_WRITE_CONTRACT_PACKAGE    = @"TransformWriteContractPackage";
NSString *const TRANSFORM_WRITE_DEPLOY_INFO         = @"TransformWriteDeployInfo";
NSString *const TRANSFORM_WRITE_ERA_INFO            = @"TransformWriteEraInfo";
NSString *const TRANSFORM_WRITE_TRANSFER            = @"TransformWriteTransfer";
NSString *const TRANSFORM_WRITE_BID                 = @"TransformWriteBid";
NSString *const TRANSFORM_WRITE_WITHDRAW            = @"TransformWriteWithdraw";
NSString *const TRANSFORM_ADD_INT32                 = @"TranformAddInt32";
NSString *const TRANSFORM_ADD_UINT64                = @"TransformAddUInt64";
NSString *const TRANSFORM_ADD_UINT128               = @"TransformAddUInt128";
NSString *const TRANSFORM_ADD_UINT256               = @"TransformAddUInt256";
NSString *const TRANSFORM_ADD_UINT512               = @"TransformAddUInt512";
NSString *const TRANSFORM_ADD_KEYS                  = @"TranformAddKeys";
NSString *const TRANSFORM_FAILURE                   = @"TransformFailure";
