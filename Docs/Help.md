# ObjectiveC Casper SDK manual on classes and methods

## RPC Calls

The calling the RPC follow this sequence:

- Create the POST request with corresponding paramters for each methods

- Send the POST request to the Casper server (test net or main net or localhost) 

- Get the Json message back from the server. The message could either be error message or the json string representing the object need to retrieve. If you send wrong parameter, such as in "chain_get_state_root_hash" RPC call, if you send BlockIdentifier with too big block height (that does not exist) then you will get error message back from Casper server. If you send correct parameter, you will get expected json message for the data you need.

- Handle the data sent back from Casper server for the POST request. Depends on the RPC method call, the corresponding json data is sent back in type of [String:Value] form. The task of the SDK is to parse this json data and put in correct data type built for each RPC method.

## List of RPC methods:

1) [Get state root hash (chain_get_state_root_hash)](#i-get-state-root-hash)

2) [Get peer list (info_get_peers)](#ii-get-peers-list)

3) [Get Deploy (info_get_deploy)](#iii-get-deploy)

4) [Get Status (info_get_status)](#iv-get-status)

5) [Get Block transfer (chain_get_block_transfers)](#v-get-block-transfers)

6) [Get Block (chain_get_block)](#vi-get-block)

7) [Get Era by switch block (chain_get_era_info_by_switch_block)](#vii-get-era-info-by-switch-block)

8) [Get Item (state_get_item)](#vii-get-item)

9) [Get Dictionary item (state_get_dictionary_item)](#ix-get-dictionaray-item)

10) [Get balance (state_get_balance)](#x-get-balance)

11) [Get Auction info (state_get_auction_info)](#xi-get-auction-info)

12) Put Deploy (account_put_deploy) 

### I. Get State Root Hash  

The task is done in file "GetStateRootHash.h" and "GetStateRootHash.m"

#### 1. Method declaration

```ObjectiveC
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString 
```

#### 2. Input & Output: 

Input: NSString represents the json parameter needed to send along with the POST method to Casper server. This parameter is build based on the BlockIdentifier.

When call this method to get the state root hash, you need to declare a BlockIdentifier object and then assign the height or hash or just none to the BlockIdentifier. Then the BlockIdentifier is transfer to the jsonString parameter. The whole sequence can be seen as the following code:
1. Declare a BlockIdentifier and assign its value
```ObjectiveC
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    
    //or you can set the block attribute like this
    
    //bi.blockType = USE_BLOCK_HASH;
   // [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
   
   or like this
   
   //bi.blockType = USE_BLOCK_HEIGHT;
   // [bi assignBlockHeigthtWithParam:12345];
   
   //then you generate the jsonString to call the getStateRootHashWithJsonParam function
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_state_root_hash"];
```
2. Use the jsonString to call the function:

```ObjectiveC
+(void) getStateRootHashWithJsonParam:(NSString*) jsonString 
```

Output: the actual output is retrieved within the function body of getStateRootHashWithJsonParam function:

```ObjectiveC
[HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
```
From this the other method is called

```ObjectiveC
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData 
```

This function return the state_root_hash value.

#### 3. The Unit test file for GetStateRootHash is in file "GetStateRootHashTest.m". 

In Unit test, the GetStateRootHash is done within the following sequence:

1. Declare a BlockIdentifier and assign its atributes

```ObjectiveC
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    
    //or you can set the block attribute like this
    
    //bi.blockType = USE_BLOCK_HASH;
   // [bi assignBlockHashWithParam:@"d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"];
   
   or like this
   
   //bi.blockType = USE_BLOCK_HEIGHT;
   // [bi assignBlockHeigthtWithParam:12345];
   
   //then you generate the jsonString to call the getStateRootHashWithJsonParam function
    NSString * jsonString = [bi toJsonStringWithMethodName:@"chain_get_state_root_hash"];
```
2. Call the function to get the state root hash

```ObjectiveC
[self getStateRootHashWithJsonParam:jsonString];
```

### II. Get Peers List  

The task is done in file "GetPeerResult.h" and "GetPeerResult.m"

#### 1. Method declaration

```ObjectiveC
+(void) getPeerResultWithJsonParam:(NSString*) jsonString;
```

#### 2. Input & Output: 

Input: NSString represents the json parameter needed to send along with the POST method to Casper server. This string is just simple as:

```ObjectiveC
{"params" : [],"id" : 1,"method":"info_get_peers","jsonrpc" : "2.0"}
```

The code under  function handler the getting of peerlist

```ObjectiveC
[HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_INFO_GET_PEERS];
```

From this, in HttpHandler class, the retrieve of PeerEntry List is done with this function:

```ObjectiveC
+(GetPeerResult*) fromJsonObjToGetPeerResult:(NSDictionary*) jsonDict;
```

- Output: List of peer defined in class GetPeersResult, which contain a list of PeerEntry - a class contain of nodeId and address.

#### 3. The Unit test file for GetPeerResult is in file "GetPeerResultTest.m"

The steps in doing the test.

1.Declare the json parameter to send to POST request

```ObjectiveC
NSString *jsonString = @"{\"params\" : [],\"id\" : 1,\"method\":\"info_get_peers\",\"jsonrpc\" : \"2.0\"}";
```
From the POST request, the json data is retrieved and stored in forJSONObject variable.

2. Get GetPeerResult from the forJSONObject variable

```ObjectiveC
GetPeerResult * gpr = [[GetPeerResult alloc] init];
        gpr = [GetPeerResult fromJsonObjToGetPeerResult:forJSONObject];
```

From this you can Log out the retrieved information, such as the following code Log out total peer and print address and node id for each peer.

```ObjectiveC
NSLog(@"Get peer result api_version:%@",gpr.api_version);
NSLog(@"Get peer result, total peer entry:%lu",[gpr.PeersMap count]);
NSLog(@"List of peer printed out:");
NSInteger totalPeer = [gpr.PeersMap count];
NSInteger  counter = 1;
for (int i = 0 ; i < totalPeer;i ++) {
    PeerEntry * pe = [[PeerEntry alloc] init];
    pe = [gpr.PeersMap objectAtIndex:i];
    NSLog(@"Peer number %lu address:%@ and node id:%@",counter,pe.address,pe.nodeID);
    counter = counter + 1;
}
```

### III. Get Deploy 

#### 1. Method declaration

```ObjectiveC
+(GetDeployResult*) fromJsonDictToGetDeployResult:(NSDictionary*) fromDict  
```

#### 2. Input & Output: 


### IV. Get Status

#### 1. Method declaration

```ObjectiveC
+(GetStatusResult *) fromJsonDictToGetStatusResult:(NSDictionary*) jsonDict
```

#### 2. Input & Output: 

### V. Get Block Transfers

#### 1. Method declaration

```ObjectiveC
+(GetBlockTransfersResult *) fromJsonDictToGetBlockTransfersResult:(NSDictionary*) jsonDict
```

#### 2. Input & Output: 

### VI. Get Block 

#### 1. Method declaration

```ObjectiveC
+(GetBlockResult*) fromJsonDictToGetBlockResult:(NSDictionary *) jsonDict 
```

#### 2. Input & Output: 

### VII. Get Era Info By Switch Block

#### 1. Method declaration

```ObjectiveC
+(GetEraInfoResult*) fromJsonDictToGetEraInfoResult:(NSDictionary*) fromDict 
```

#### 2. Input & Output: 


### VII. Get Item

#### 1. Method declaration

```ObjectiveC
+(GetItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict 
```

#### 2. Input & Output: 

### IX. Get Dictionaray Item

#### 1. Method declaration

```ObjectiveC
+(GetDictionaryItemResult*) fromJsonDictToGetItemResult:(NSDictionary*) fromDict 
```

#### 2. Input & Output: 

### X. Get Balance

#### 1. Method declaration

```ObjectiveC
+(GetBalanceResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict 
```

#### 2. Input & Output: 

### XI. Get Auction Info

#### 1. Method declaration

```ObjectiveC
+(GetAuctionInfoResult*) fromJsonDictToGetBalanceResult:(NSDictionary*) fromDict 
```

#### 2. Input & Output: 







