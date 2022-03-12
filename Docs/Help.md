# ObjectiveC Casper SDK manual on classes and methods

## RPC Calls

The calling the RPC follow this sequence:

- Create the POST request with corresponding paramters for each methods

- Send the POST request to the Casper server (test net or main net or localhost) 

- Get the Json message back from the server. The message could either be error message or the json string representing the object need to retrieve. If you send wrong parameter, such as in "chain_get_state_root_hash" RPC call, if you send BlockIdentifier with too big block height (that does not exist) then you will get error message back from Casper server. If you send correct parameter, you will get expected json message for the data you need.

- Handle the data sent back from Casper server for the POST request. Depends on the RPC method call, the corresponding json data is sent back in type of [String:Value] form. The task of the SDK is to parse this json data and put in correct data type built for each RPC method.

Here is the RPC methods need to be implemented, in which for M1 is the first 2 methods:

1) Get state root hash (chain_get_state_root_hash)

2) Get peer list (info_get_peers)

3) Get Deploy (info_get_deploy)

4) Get Status (info_get_status)

5) Get Block transfer (chain_get_block_transfers)

6) Get Block (chain_get_block)

7) Get Era by switch block (chain_get_era_info_by_switch_block)

8) Get Item (state_get_item)

9) Get Dictionary item (state_get_dictionary_item)

10) Get balance (state_get_balance)

11) Get Auction info (state_get_auction_info)

12) Put Deploy (account_put_deploy) 

### I. Get State Root Hash  

The task is done in file "GetStateRootHash.h" and "GetStateRootHash.m"

#### 1. Method declaration

```ObjectiveC
        +(void) getStateRootHashWithJsonParam:(NSString*) jsonString 
```
Input: NSString represents the json parameter needed to send along with the POST method to Casper server
Output: the actual output is retrive within the function body

```ObjectiveC
    [HttpHandler handleRequestWithParam:jsonString andRPCMethod:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
```
From this the other method is called

```ObjectiveC
+(NSString*) fromJsonToStateRootHash:(NSDictionary*) nsData 
```

This function return the state_root_hash value.

In Unit test, the GetStateRootHash is done within the following sequence:

#### 2. Input & Output: 



Base on the input, the folowing output is possible:

- Input: Hash(block_hash) with correct block_hash of a block, Output: the state root hash of the block with the specific hash of the input

- Input: Hash(block_hash) with wrong block_hash or non-exist block_hash, Output: the state root hash of the latest block

- Input: Height(block_height) with correct block_height, Output: the state root hash of the block with the specific height of the input 

- Input: Height(block_height) with wrong block_height, such as the value is too big, Output: A block not found Error is thrown.

#### 3. Method flow detail:

- input getStateRootHashParam of type GetStateRootHashParam will be used to make json data for post method 

```swift
let data = JsonConversion.fromBlockIdentifierToJsonData(input: getStateRootHashParam.block_identifier, method: .chainGetStateRootHash)
```

- Then json data will be sent to the  httpHandler object of HttpHandler class with the method call and json data just generated.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the state root hash is retrieved by running this code line

```swift
let stateRootHash = try GetStateRootHash.getStateRootHash(from: responseJSON);
```

### II. Get network peers list  

#### 1. Method declaration

```swift
public func getPeers()
```

#### 2. Input & Output: 

- Input: None

- Output: List of peer defined in class GetPeersResult, which contain a list of PeerEntry - a class contain of nodeId and address.


#### 3. Method flow detail:

- Call to  httpHandler object of HttpHandler class.

```swift
httpHandler.handleRequest(method: methodCall, params: data)
```

In the handleRequest function the peer list is retrieved by running this code line

```swift
let getPeer:GetPeersResult = try GetPeers.getPeers(from: responseJSON)
```

You can then retrieve all the peer through the getPeer object (of class GetPeersResult), for example this following code log out all retrieved peers:

```swift
let peerEntries:[PeerEntry] = getPeer.getPeerMap().getPeerEntryList()
for peerEntry in peerEntries {
    NSLog("Peer address:\(peerEntry.address)")
    NSLog("Peer id:\(peerEntry.nodeID)")
}
```

