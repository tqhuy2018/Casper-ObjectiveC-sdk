# CSPR-ObjectiveC-SDK

ObjectiveC SDK library for interacting with a CSPR node.

## What is CSPR-ObjectiveC-SDK?

SDK  to streamline the 3rd party ObjectiveC client integration processes. Such 3rd parties include exchanges & app developers. 

## System requirement

The SDK use ObjectiveC 2.0 and support device running IOS from 12.0, MacOS from 10.15, WatchOS from 5.3, tvOS from 12.3

## Build and test

The package can be built an tested from Xcode IDE or Terminal in MacOS

### Build and test in Xcode IDE

To test the project you need to have a Mac with Mac OS and XCode 13 or above to build and run the test.

Download or clone the code from github, then open it with Xcode.

* Configure the Minimum MacOS and IOS version for Package and Test Target:

Check your configuration is the same as below for the SDK in Xcode.

In TARGETS section of Xcode, choose "CasperSDKObjectiveC". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:
<img width="1126" alt="Screen Shot 2022-03-12 at 22 09 58" src="https://user-images.githubusercontent.com/94465107/158023543-d7cdff7b-98f0-45fa-b36e-a268a78f66af.png">


In TARGETS section of Xcode, choose "CasperSDKObjectiveCTests". Hit "Build Settings" tab in the Target menu, seach for "macOS Development Target", then choose "macOS 10.15" from the Dropdown list, like in this image:

<img width="1127" alt="Screen Shot 2022-03-12 at 22 10 15" src="https://user-images.githubusercontent.com/94465107/158023549-1216b6f8-7245-4ccf-a810-6f08b5d49446.png">


* Configure "Signing & Capabilities"

The default configuration for both "CasperSDKObjectiveC" and "CasperSDKObjectiveCTests" in this section is in the image below

<img width="868" alt="Screen Shot 2022-03-12 at 22 05 01" src="https://user-images.githubusercontent.com/94465107/158023373-face5ad9-d00d-4a90-91df-828d4dfff34d.png">

<img width="866" alt="Screen Shot 2022-03-12 at 22 05 58" src="https://user-images.githubusercontent.com/94465107/158023400-c21e1b89-20c3-4533-85ec-b6aa6c4711cd.png">

In the menu bar of XCode, hit Product->Build to build the SDK.
<img width="1397" alt="Screen Shot 2022-03-12 at 22 15 08" src="https://user-images.githubusercontent.com/94465107/158023727-264cd412-762e-40de-b52b-29b0b682af94.png">


In the menu bar of XCode, hit Product->Test to test the SDK.
<img width="1406" alt="Screen Shot 2022-03-12 at 22 16 44" src="https://user-images.githubusercontent.com/94465107/158023788-ea87de66-687e-41c6-9469-78881e48f2be.png">

You will see the Log information about List Peer and State root hash for the 2 RPC method. (Press "Cmd + Shift + Y" to show the Log if you don't see it)

### Build and test in Terminal

You can check the build and test result from the "Actions" section of the SDK in Github. There is a ".yml" file for building and testing the sdk using Github simulator for MacOS environment, as you can see in this image.

<img width="1394" alt="Screen Shot 2022-03-20 at 13 21 29" src="https://user-images.githubusercontent.com/94465107/159150799-989d786a-6f22-40a9-bbae-53c8b2916027.png">


If you want to make it locally, you still need a Mac running MacOS 10.15 (or above) and  Xcode 13.0 (or above) installed, then follow these steps:

1) Download or clone the SDK from Github
 
2) Configure the Package in XCode to sign the SDK for one Development Team or Distribution Team

3) In terminal enter the folder of the SDK. Run the following commands to build or test trom the folder root of the SDK in terminal:

To build package run this command line:

```ObjectiveC
xcodebuild -scheme CasperSDKObjectiveC build
```
To test package run this command line:

```ObjectiveC
xcodebuild test -scheme CasperSDKObjectiveCTests
```

Other comments on the test implementation:

* There are logInfo function in all mandatory functions of classes, which are to show the result of the retrieving information. They will be removed in final phase of the project.(Milestone 4)

* To see test result of Milestone 1, please search this text "M1: chain_get_state_root_hash test cases" for the result of "chain_get_state_root_hash" RPC call and search for text "M1: info_get_peers test cases" for the result of "info_get_peers" RPC call in the Test log. The rest result is for M2 information log.

# Documentation for classes and methods

* [List of classes and methods](./Docs/Help.md#list-of-rpc-methods)

  -  [Get State Root Hash](./Docs/Help.md#i-get-state-root-hash)

  -  [Get Peer List](./Docs/Help.md#ii-get-peers-list)

  -  [Get Deploy](./Docs/Help.md#iii-get-deploy)
  
  -  [Get Status](./Docs/Help.md#iv-get-status)
  
  -  [Get Block Transfers](./Docs/Help.md#v-get-block-transfers)
  
  -  [Get Block](./Docs/Help.md#vi-get-block)
  
  -  [Get Era Info By Switch Block](./Docs/Help.md#vii-get-era-info-by-switch-block)
  
  -  [Get Item](./Docs/Help.md#vii-get-item)
  
  -  [Get Dictionary Item](./Docs/Help.md#ix-get-dictionaray-item)
  
  -  [Get Balance](./Docs/Help.md#x-get-balance)
  
  -  [Get Auction Info](./Docs/Help.md#xi-get-auction-info)
 
 # ObjectiveC version of CLType primitives, Casper Domain Specific Objects and Serialization
 
 ## CLType primitives
 
 The CLType is an enum variables, defined at this address: (for Rust version)
 
 https://docs.rs/casper-types/1.4.6/casper_types/enum.CLType.html
 
 In ObjectiveC, the CLType when put into usage is part of a CLValue object.
 
 To more detail, a CLValue holds the information like this:
 
 ```ObjectiveC
 {
"bytes":"0400e1f505"
"parsed":"100000000"
"cl_type":"U512"
}
```

or


 ```ObjectiveC
 {
"bytes":"010000000100000009000000746f6b656e5f7572695000000068747470733a2f2f676174657761792e70696e6174612e636c6f75642f697066732f516d5a4e7a337a564e7956333833666e315a6762726f78434c5378566e78376a727134796a4779464a6f5a35566b"
"parsed":[
          [
             {
             "key":"token_uri"
             "value":"https://gateway.pinata.cloud/ipfs/QmZNz3zVNyV383fn1ZgbroxCLSxVnx7jrq4yjGyFJoZ5Vk"
             }
          ]
]
"cl_type":{
        "List":{
           "Map":{
           "key":"String"
           "value":"String"
           }
      }
}
 ```
The CLValue is built up with 3 elements: cl_type, parsed and bytes.
In the examples above, 
 * For the first example:
   - The cl_type is: U512 
   - The parsed is: "100000000" 
   - The bytes is: "0400e1f505"  

 * For the second example: 
   - The cl_type is: List(Map(String,String))
   - The parsed is: 
 
 ```ObjectiveC
 "[
          [
             {
             "key":"token_uri"
             "value":"https://gateway.pinata.cloud/ipfs/QmZNz3zVNyV383fn1ZgbroxCLSxVnx7jrq4yjGyFJoZ5Vk"
             }
          ]
       ]"
  ```
  
     - The bytes is: "010000000100000009000000746f6b656e5f7572695000000068747470733a2f2f676174657761792e70696e6174612e636c6f75642f697066732f516d5a4e7a337a564e7956333833666e315a6762726f78434c5378566e78376a727134796a4779464a6f5a35566b"
 
In ObjectiveC the "cl_type" is wrapped in CLType class, which is declared in  CLType.h and CLType.m file. The CLType class stores all information need when you want to declare a CLType, and also this class provides functions to turn JSON object to CLType object and supporter function such as function to check if the CLType hold pure value of CLType with recursive CLType inside its body.
 
The "parsed" is wrapped in CLParsed class, which is declared in  CLParsed.h and CLParsed.m file. The CLParsed class stores all information need when you want to declare a CLParsed object, and also this class provides functions to turn JSON object to CLParsed object and supporter function such as function to check if the CLParsed hold pure value of CLType object or with hold value of recursive CLType object inside its body.

 To store information of one CLValue object, which include the following information: {bytes,parsed,cl_type}, this SDK uses a class with name CLValue, which is declared in CLValue.h and CLValue.m file. with main information like this:
  
 ```ObjectiveC
@interface CLValue:NSObject
@property NSString * bytes;
@property CLType * cl_type;
@property CLParsed * parsed;
@end
 ```
This class also provide a supporter function to parse a JSON object to CLValue object.

When get information for a deploy, for example, the args of the payment/session or items in the execution_results can hold CLValue values, and they will be turned to CLValue object in ObjectiveC to support the work of storing information and doing the serialization.

 ## Casper Domain Specific Objects

 All of the main Casper Domain Specific Objects is built in ObjectiveC with classes like Deploy, DeployHeader, ExecutionDeployItem, NamedArg, Approval,  JsonBlock, JsonBlockHeader, JsonEraEnd, JsonEraReport, JsonBlockBody, JsonProof, ValidatorWeight, Reward, ... and so on. All the class belonging to the RPC call is built to store coressponding information.
 
 ## Serialization
 
 The serialization is build for the following classes & objects:
  
  - CLType serialization
  - CLParse serialization
  - Deploy serialization (which include: Deploy header serialization, ExecutableDeployItem serialization for deploy payment and deploy session, Deploy Approvals serialization)

In detail:
 ###  CLType serialization
 The CLType serialization is processed in CLTypeSerializeHelper.h and CLTypeSerializeHelper.m file. For each of the 23 possible types, the serialization result is a string for that type. The returned string is  based on the following rule:
    - CLType Bool the return string is "00"
    - CLType Int32 the return string is "01"
    - CLType Int64 the return string is "02"
    - CLType U8 the return string is "03"
    - CLType U32 the return string is "04"
    - CLType U64 the return string is "05"
    - CLType U128 the return string is "06"
    - CLType U256 the return string is "07"
    - CLType U512 the return string is "08"
    - CLType Unit the return string is "09"
    - CLType String the return string is "0a"
    - CLType Key the return string is "0b"
    - CLType URef the return string is "0c"
    - CLType Option the return string is "0d" + CLType.serialize for Option inner CLType
    - CLType List the return string is "0e" + CLType.serialize for List inner CLType
    - CLType ByteArray the return string is "0f"
    - CLType Result the return string is "10" + CLType.serialize for "Ok" inner CLType + CLType.serialize for "Err" inner CLType
    - CLType Map the return string is "11" + CLType.serialize for "key" inner CLType + CLType.serialize for "value" inner CLType
    - CLType Tuple1 the return string is "12" + CLType.serialize for Tuple1 inner CLType
    - CLType Tuple2 the return string is "13" + CLType.serialize for Tuple2 inner CLType 1 + CLType.serialize for Tuple2 inner CLType 2
    - CLType Tuple3 the return string is "14" + CLType.serialize for Tuple3 inner CLType 1 + CLType.serialize for Tuple3 inner CLType 2 + CLType.serialize for Tuple3 inner CLType 3
    - CLType Any the return string is "15"
    - CLType PublicKey the return string is "16"
### CLParse serialization
The CLParse serialization is done with the reference to the document at this address:

https://casper.network/docs/design/serialization-standard#serialization-standard-state-keys

and the work of serialization is done through the class CLParseSerializeHelper which declared in file CLParseSerializeHelper.h and CLParseSerializeHelper.m

This class provides all the function necessary to serialize for all parsed value of all 23 possible values of CLType, for example the function : 

 ```ObjectiveC
+(NSString*) serializeFromCLParseInt32:(CLParsed*) fromCLParse;
 ```
 
 is for Int32 serialization, or 

 ```ObjectiveC
+(NSString*) serializeFromCLParseTuple2:(CLParsed*) fromCLParse;
 ```
 
 is for the parsed of CLType Tuple2 serialization.

### Deploy serialization

The deploy serialization is built base on the content of the deploy itself. The class for doing this is DeploySerializeHelper class defined in "DeploySerializeHelper.h" and "DeploySerializeHelper.m" file.

There are 3 main function in this class for serialization of deploy header, deploy approvals and deploy. The deploy payment and session is of type ExecutableDeployItem and is serialized with ExecutableDeployItemSerializationHelper class, defined in "ExecutableDeployItemSerializationHelper.h" and "ExecutableDeployItemSerializationHelper.m" file.

The rule for deploy header serialization is:

Deploy header serialization = deployHeader.account + U64.serialize(deployHeader.timeStampMiliSecondFrom1970InU64) + U64.serialize(deployHeader.ttlMilisecondsFrom1980InU64) + U64.serialize(gas_price) + deployHeader.bodyHash

The rule for ExecutableDeployItem serialization (deploy payment and deploy session):

 ```ObjectiveC
 - For ExecutableDeployItem of type ModuleBytes: Serialization result = "00" + String.serialize(module_bytes) + args.serialization
 - For ExecutableDeployItem of type StoredContractByHash: Serialization result = "01" + hash + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredContractByName: Serialization result =  "02" + String.serialize(name) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredVersionedContractByHash: Serialization result = "03" + hash + Option(U32).serialize(version) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredVersionedContractByName: Serialization result = "04" + String.serialize(name) + Option(U32).serialize(version) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type Transfer: Serialization result = "05" + args.serialization
 ```

