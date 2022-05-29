# CSPR-ObjectiveC-SDK

ObjectiveC SDK library for interacting with a CSPR node.

## What is CSPR-ObjectiveC-SDK?

SDK  to streamline the 3rd party ObjectiveC client integration processes. Such 3rd parties include exchanges & app developers. 

## System requirement

The SDK use ObjectiveC 2.0 and support device running IOS from 13.0, MacOS from 10.15, WatchOS from 5, tvOS from 12

## Build and test

The package can be built an tested from Xcode IDE or Terminal in MacOS

### Build and test in Xcode IDE

To test the project you need to have a Mac with Mac OS and XCode 13 or above to build and run the test.

Download or clone the code from github, then open it with Xcode by Double click the "Package.swift" file.

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
<img width="1440" alt="Screen Shot 2022-05-29 at 18 29 10" src="https://user-images.githubusercontent.com/94465107/170865676-732258d2-b6e4-43d5-a8f5-ea9362aa38d1.png">


In the menu bar of XCode, hit Product->Test to test the SDK.
<img width="1440" alt="Screen Shot 2022-05-29 at 18 15 04" src="https://user-images.githubusercontent.com/94465107/170865657-a0a6a1f5-2c36-46f5-9b31-06ea5a2e481c.png">


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

### Other comments on the test implementation:


There are logInfo function in all mandatory functions of classes, which are to show the result of the retrieving information. They will be removed in final phase of the project.(Milestone 4)

# Information for Secp256k1, Ed25519 Key Wrapper and Put Deploy

## Key wrapper specification:

The Key wrapper do the following work:(for both Secp256k1 and Ed25519):

- (PrivateKey,PublicKey) generation

- Sign message 

- Verify message

- Read PrivateKey/PublicKey from PEM file

- Write PrivateKey/PublicKey to PEM file

The key wrapper is used in account_put_deploy RPC method to generate approvals signature based on deploy hash.

The core Ed25519 and Secp256k1 Crypto is not avaiable in ObjectiveC native, but the taskes for these cryptos can be done by calling Swift libraries and online packages, which are encapsulated in one Swift package at this address:

https://github.com/hienbui9999/CasperCryptoHandlePackage

This package is written in Swift for handling Ed25519 and Secp256k1 crypto tasks and provide protocol with wrapped classes for ObjectiveC to call certain crypto functions. This package also provide Blake2b256 function for ObjectiveC.

To use the functions and classes in this package, simply add the package in file "Package.swift" by this declaration:
(Please see the Package.swift file under the Casper-ObjectiveC-sdk package)

 ```ObjectiveC
dependencies: [
    .package(name: "CasperCryptoHandlePackage", url: "https://github.com/hienbui9999/CasperCryptoHandlePackage.git", from: "1.0.2"),
],
```

In any ObjectiveC file, to use the Crypto function that this package provides, simply add this import at the beginning of the  ObjectiveC file.

 ```ObjectiveC
@import CasperCryptoHandlePackage;
```

In Casper ObjectiveC SDK, the Ed25519 task is done in file "Secp256k1Crypto.m" in "Crypto" folder. This file provides all functions for all the crypto tasks above.
For example, to generate the Private and Public key, please refer to function 

 ```ObjectiveC
-(CryptoKeyPair *) generateKey {
    CryptoKeyPair * ret = [[CryptoKeyPair alloc] init];
    Ed25519CrytoSwift * ed25519 = [[Ed25519CrytoSwift alloc] init];
    KeyPairClass * kpc = [ed25519 generateKeyPair];
    ret.privateKeyStr = kpc.privateKeyInStr;
    ret.publicKeyStr = kpc.publicKeyInStr;
    return ret;
}
```

This function use a "Ed25519CrytoSwift" class object from the Swift package "CasperCryptoHandlePackage"
This object provides function "generateKeyPair" which return an object holding the Private and Public key pair in form of a string repesent the key bytes.
For example the Private key is somehow like this in ObjectiveC: 58_1_61_242_77_251_54_204_135_74_45_117_67_18_30_184_144_193_158_142_182_68_229_185_27_56_181_134_38_235_28_51 
_ And the Public key is somehow like this: 138_121_31_76_52_190_241_244_216_11_26_29_151_147_196_119_186_49_12_134_43_21_243_127_134_56_3_169_170_156_4_233 _


## Put deploy specification:

The put deploy RPC method implements the call "account_put_deploy". User needs to declare a deploy and assign the information for the deploy (header,payment,session,approvals). The following information is generated based on the deploy:

- Deploy body hash - base on the serialization of deploy body, which is a string of payment serialization + deploy session serialization. Then use the blake2b256 hash over the generated serialized string to make the deploy body hash. The deploy body hash is an attribute of the deploy header.

- Deploy hash: Use the blake2b256 hash over the header of the deploy.

- Signature in deploy approvals is generated using the deploy hash using the key wrapper to sign over the deploy hash. You can use either Secp256k1 or Ed25519 to sign over the deploy hash, based on the account type of the deploy. If the deploy use account of type Secp256k1 then you have to sign with Secp256k1 key. If the deploy use account of type Ed25519 then you have to sign with Ed25519 key.

- The whole deploy with full information is then serialized to a Json string and sent with a POST request to Casper main or test net, or localhost to call account_put_deploy RPC method.

### To call the Put Deploy correctly, remember to do the following thing:

- Know what your account type is, Ed25519 or Secp256k1.

- Save your private key in 1 place that you can point to from code.

- Choose correct path to private key to sign for the deploy hash in put deploy function.

## Sample project using the Casper ObjectiveC SDK

Please refer to this address for a sample of 1 ObjectiveC project that call the Casper ObjectiveC SDK.

In this project, some RPC calls are written.

https://github.com/hienbui9999/SampleCallToCasperObjectiveCSDK

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
     
### CLType in detail

In ObjectiveC the "cl_type" is wrapped in CLType class, which is declared in  CLType.h and CLType.m file. The CLType class stores all information need when you want to declare a CLType, and also this class provides functions to turn JSON object to CLType object and supporter function such as function to check if the CLType hold pure value of CLType with recursive CLType inside its body.

The main properties of the CLType object are:

 ```ObjectiveC
@property NSString * itsType;
@property CLType * innerType1;
@property CLType * innerType2;
@property CLType * innerType3;
 ```
 
 In which the property "itsType" is to hold information of the CLType type, which can be 1 among 23 possible value from "Bool", "I32","I64", "U8" ... to "Tuple1", "Tuple2", "Tuple3" and "Any".
 
The innerType1 is to hold the inner CLType for the following CLType: List, Tuple1, Option

The innerType1 and innerType2 is to hold the inner CLType for the following CLType: Map, Result, Tuple2

The innerType1 and innerType2 and innerType3 is to hold the inner CLType for the following CLType: Tuple3

#### Here are some examples of declaring the CLType object for some types: 

To declare for a CLType of type Bool:
  
 ```ObjectiveC
  CLType * typeBool = [[CLType alloc] init];
  typeBool.itsType = CLTYPE_BOOL;
  ```
  
To declare for a CLType of type List(Map(String,U32)):
  
 ```ObjectiveC
    CLType * mapKeyType = [[CLType alloc] init];
    mapKeyType.itsType = CLTYPE_STRING;
    CLType * mapValueType = [[CLType alloc] init];
    mapValueType.itsType = CLTYPE_U32;
    CLType * typeMap = [[CLType alloc] init];
    typeMap.itsType = CLTYPE_MAP;
    typeMap.innerType1 = mapKeyType;
    typeMap.innerType2 = mapValueType;
    CLType * typeList = [[CLType alloc] init];
    typeList.itsType = CLTYPE_LIST;
    typeList.innerType1 = typeMap;
  ```

### CLParsed in detail 

The "parsed" is wrapped in CLParsed class, which is declared in  CLParsed.h and CLParsed.m file. The CLParsed class stores all information need when you want to declare a CLParsed object, and also this class provides functions to turn JSON object to CLParsed object and supporter function such as function to check if the CLParsed hold pure value of CLType object or with hold value of recursive CLType object inside its body.

The main properties of the CLParsed object are:

 ```ObjectiveC
@property CLType * itsCLType;
@property NSString * itsValueStr;
@property CLParsed * innerParsed1;
@property CLParsed * innerParsed2;
@property CLParsed * innerParsed3;
@property NSMutableArray * arrayValue;
@property NSString * itsCLTypeStr;
 ```

 In which the property "itsCLType" is to hold CLType of the CLParsed object, which can be 1 among 23 possible value from "Bool", "I32","I64", "U8" ... to "Tuple1", "Tuple2", "Tuple3" and "Any".
 
The property itsValueStr is to hold value of CLParsed that doesn't contain recursive CLParsed inside its body

The property arrayValue is to hold value of List and FixedList elements
 
The innerParsed1 is to hold the inner CLParsed object for the following CLType: Tuple1, Option

The innerParsed1 and innerParsed2 is to hold the inner CLParsed for the following CLType: Map, Result, Tuple2

The innerParsed1 and innerParsed2 and innerParsed3 is to hold the inner CLParsed for the following CLType: Tuple3

itsCLTypeStr is a short way to get the direct CLType of the CLParsed. The value of itsCLTypeStr is 1 among 23 possible value of the CLType. With this attribute, you can know very fast the topmost CLType of the CLParsed (if the CLParsed hold recursive CLParsed inside its body, such as List, Map, Result, Option, Tuple1, Tuple2, Tuple3)

#### Here are some examples of declaring the CLParsed object for some types: 

To declare for a CLParsed of type U512 with value "1234":

 ```ObjectiveC
    CLParsed * parseU512 = [[CLParsed alloc] init];
    CLType * typeU512 = [[CLType alloc] init];
    typeU512.itsType = CLTYPE_U512;
    parseU512.itsValueStr = @"1234";
    parseU512.itsCLType = typeU512;
 ```
 or just simple like this:
 
  ```ObjectiveC
    CLParsed * parseU512 = [[CLParsed alloc] init];
    parseU512.itsValueStr = @"1234";
    parseU512.itsCLTypeStr = CLTYPE_U512;
 ```
 
To declare for a CLParsed of type List(I64) with the value of {10,20,30}:

```ObjectiveC
    CLParsed * parsedList = [[CLParsed alloc] init];
    //Assign the cltype for clparsed
    //Declare for the CLType
    CLType * typeList = [[CLType alloc] init];
    typeList.itsType = CLTYPE_LIST;
    CLType * typeI64 = [[CLType alloc] init];
    typeI64.itsType = CLTYPE_I64;
    typeList.innerType1 = typeI64;
    parsedList.itsCLType = typeList;
    //Assign the value for CLParsed
    CLParsed * parsed641 = [[CLParsed alloc] init];
    parsed641.itsCLTypeStr = CLTYPE_U64;
    parsed641.itsValueStr = @"10";
    CLParsed * parsed642 = [[CLParsed alloc] init];
    parsed642.itsCLTypeStr = CLTYPE_U64;
    parsed642.itsValueStr = @"20";
    CLParsed * parsed643 = [[CLParsed alloc] init];
    parsed643.itsCLTypeStr = CLTYPE_U64;
    parsed643.itsValueStr = @"30";
    parsedList.arrayValue = [[NSMutableArray alloc] init];
    [parsedList.arrayValue addObject:parsed641];
    [parsedList.arrayValue addObject:parsed642];
    [parsedList.arrayValue addObject:parsed643];
 ```

 ### CLValue in detail
 
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

### Example of declaring CLValue object

Take this CLValue in JSON

 ```ObjectiveC
 {
"bytes":"0400e1f505"
"parsed":"100000000"
"cl_type":"U512"
}
```

This JSON will turn to a CLValue like this:

 ```ObjectiveC
 CLValue * clValue = [[CLValue alloc] init];
 //assignment for bytes
 clValue.bytes = @"0400e1f505";
 //assignment for parsed
 CLParsed * parsed = [[CLParsed alloc] init];
 parsed.itsValueStr = @"100000000";
 parsed.itsCLTypeStr = CLTYPE_U512;
 clValue.parsed = parsed;
 //assignment for cl_type
 CLType * clType = [[CLType alloc] init];
 clType.itsType = CLTYPE_U512;
 clValue.cl_type = clType;
```

Take this CLValue in JSON:

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
 
 This JSON will turn to a CLValue like this:
 
 ```ObjectiveC
  CLValue * clValue = [[CLValue alloc] init];
    //assignment for bytes
    clValue.bytes = @"010000000100000009000000746f6b656e5f7572695000000068747470733a2f2f676174657761792e70696e6174612e636c6f75642f697066732f516d5a4e7a337a564e7956333833666e315a6762726f78434c5378566e78376a727134796a4779464a6f5a35566b";
    
    //assignment for cl_type
   CLType * mapKeyType = [[CLType alloc] init];
   mapKeyType.itsType = CLTYPE_STRING;
   CLType * mapValueType = [[CLType alloc] init];
   mapValueType.itsType = CLTYPE_STRING;
   CLType * typeMap = [[CLType alloc] init];
   typeMap.itsType = CLTYPE_MAP;
   typeMap.innerType1 = mapKeyType;
   typeMap.innerType2 = mapValueType;
   CLType * typeList = [[CLType alloc] init];
   typeList.itsType = CLTYPE_LIST;
   typeList.innerType1 = typeMap;
    clValue.cl_type = typeList;
    
    //assignment for parsed
    CLParsed * parsedList = [[CLParsed alloc] init];
    parsedList.itsCLType = typeList;
    //define the List inner Parsed type of ClParseMap
    CLParsed * parsedMap = [[CLParsed alloc] init];
    //to hold the key list of the map
    parsedMap.innerParsed1 = [[CLParsed alloc] init];
    CLParsed * key1 = [[CLParsed alloc] init];
    key1.itsValueStr = @"token_uri";
    key1.itsCLTypeStr = CLTYPE_U512;
    parsedMap.innerParsed1.arrayValue = [[NSMutableArray alloc] init];
    [parsedMap.innerParsed1.arrayValue addObject:key1];
    //to hold the value list of the map
    parsedMap.innerParsed2 = [[CLParsed alloc] init];
    CLParsed * value1 = [[CLParsed alloc] init];
    value1.itsValueStr = @"https://gateway.pinata.cloud/ipfs/QmZNz3zVNyV383fn1ZgbroxCLSxVnx7jrq4yjGyFJoZ5Vk";
    value1.itsCLTypeStr = CLTYPE_U512;
    parsedMap.innerParsed2.arrayValue = [[NSMutableArray alloc] init];
    [parsedMap.innerParsed2.arrayValue addObject:value1];
    parsedList.innerParsed1 = [[CLParsed alloc] init];
    parsedList.innerParsed1.arrayValue = [[NSMutableArray alloc] init];
    [parsedList.innerParsed1.arrayValue addObject:parsedMap];
    clValue.parsed = parsedList;
```
 
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
 
 The big number (U128, U256, U512) value serialization is done through the class NumberSerialize which defined in "NumberSerialize.h" and "NumberSerialize.m" file. This class also handle some helper method for smaller number serialization, such as U32, U64, U8, I32, I64.

### Deploy serialization

The deploy serialization is built base on the content of the deploy itself. The class for doing this is DeploySerializeHelper class defined in "DeploySerializeHelper.h" and "DeploySerializeHelper.m" file.

There are 3 main function in this class for serialization of deploy header, deploy approvals and deploy. The deploy payment and session is of type ExecutableDeployItem and is serialized with ExecutableDeployItemSerializationHelper class, defined in "ExecutableDeployItemSerializationHelper.h" and "ExecutableDeployItemSerializationHelper.m" file.

#### Deploy header serialization:

The rule for deploy header serialization is:

Deploy header serialization = deployHeader.account + U64.serialize(deployHeader.timeStampMiliSecondFrom1970InU64) + U64.serialize(deployHeader.ttlMilisecondsFrom1980InU64) + U64.serialize(gas_price) + deployHeader.bodyHash

#### Deploy payment/session serialization

The rule for ExecutableDeployItem serialization (deploy payment and deploy session):

 - For ExecutableDeployItem of type ModuleBytes: 
Serialization result = "00" + String.serialize(module_bytes) + args.serialization
 - For ExecutableDeployItem of type StoredContractByHash: 
Serialization result = "01" + hash + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredContractByName: 
Serialization result =  "02" + String.serialize(name) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredVersionedContractByHash: 
Serialization result = "03" + hash + Option(U32).serialize(version) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type StoredVersionedContractByName: 
Serialization result = "04" + String.serialize(name) + Option(U32).serialize(version) + String.serialize(entry_point) + args.serialization
 - For ExecutableDeployItem of type Transfer: 
Serialization result = "05" + args.serialization

#### Deploy approvals serialization

The rule for deploy approvals serialization is:

If the approval list is empty, just return "00000000", which is equals to U32.serialize(0)

If the approval list is not empty, then first get the approval list length, then take the prefixStr = U32.serialize(approvalList.length)

Then concatenate all the elements in the approval list with rule for each element:

1 element serialization = singer + signature

Final result = prefixStr + (listApprovals.serialize)

#### Deploy serialization 

The deploy itself is serialized under this rule:

Deploy serialization  = deployHeader.serialize + deploy.hash + deployPayment.serialize + deploySession.serialize + deployApprovals.serialize
