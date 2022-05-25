// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CasperSDKObjectiveC",
    platforms: [
        .iOS(.v13), .tvOS(.v14), .watchOS(.v7), .macOS(.v11)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CasperSDKObjectiveC",
            targets: ["CasperSDKObjectiveC_CLValue","CasperSDKObjectiveC_GetStateRootHash","CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_Crypto","CasperSDKObjectiveC_GetAuctionInfo","CasperSDKObjectiveC_GetBlock","CasperSDKObjectiveC_GetBlockTransfers","CasperSDKObjectiveC_GetDeploy","CasperSDKObjectiveC_GetDictionaryItem","CasperSDKObjectiveC_GetEraInfo","CasperSDKObjectiveC_GetItem","CasperSDKObjectiveC_GetPeerList","CasperSDKObjectiveC_GetStatus","CasperSDKObjectiveC_PutDeploy","CasperSDKObjectiveC_Serialization"]),
        .library(name: "CasperSDKObjectiveC_CLValue", targets: ["CasperSDKObjectiveC_CLValue"]),
        .library(name: "CasperSDKObjectiveC_GetStateRootHash", targets: ["CasperSDKObjectiveC_GetStateRootHash"]),
        .library(name: "CasperSDKObjectiveC_CommonClasses", targets: ["CasperSDKObjectiveC_CommonClasses"]),
        .library(name: "CasperSDKObjectiveC_Crypto", targets: ["CasperSDKObjectiveC_Crypto"]),
        .library(name: "CasperSDKObjectiveC_GetAuctionInfo", targets: ["CasperSDKObjectiveC_GetAuctionInfo"]),
        .library(name: "CasperSDKObjectiveC_GetBlock", targets: ["CasperSDKObjectiveC_GetBlock"]),
        .library(name: "CasperSDKObjectiveC_GetBlockTransfers", targets: ["CasperSDKObjectiveC_GetBlockTransfers"]),
        .library(name: "CasperSDKObjectiveC_GetDeploy", targets: ["CasperSDKObjectiveC_GetDeploy"]),
        .library(name: "CasperSDKObjectiveC_GetDictionaryItem", targets: ["CasperSDKObjectiveC_GetDictionaryItem"]),
        .library(name: "CasperSDKObjectiveC_GetEraInfo", targets: ["CasperSDKObjectiveC_GetEraInfo"]),
        .library(name: "CasperSDKObjectiveC_GetItem", targets: ["CasperSDKObjectiveC_GetItem"]),
        .library(name: "CasperSDKObjectiveC_GetPeerList", targets: ["CasperSDKObjectiveC_GetPeerList"]),
        .library(name: "CasperSDKObjectiveC_GetStatus", targets: ["CasperSDKObjectiveC_GetStatus"]),
        .library(name: "CasperSDKObjectiveC_PutDeploy", targets: ["CasperSDKObjectiveC_PutDeploy"]),
        .library(name: "CasperSDKObjectiveC_Serialization", targets: ["CasperSDKObjectiveC_Serialization"]),
        
    ],
    dependencies: [
        .package(name: "CasperCryptoHandlePackage", url: "https://github.com/hienbui9999/CasperCryptoHandlePackage.git", from: "1.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CasperSDKObjectiveC_CommonClasses",
            //dependencies: ["CasperSDKObjectiveC_GetDeploy"],
            path: "Sources/CasperSDKObjectiveC/CommonClasses",
            publicHeadersPath: "Public"
                ),
        .testTarget(
            name: "CasperSDKObjectiveCTests",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_CLValue","CasperSDKObjectiveC_GetStateRootHash","CasperSDKObjectiveC_Crypto","CasperSDKObjectiveC_GetAuctionInfo","CasperSDKObjectiveC_GetBlock","CasperSDKObjectiveC_GetBlockTransfers","CasperSDKObjectiveC_GetDeploy","CasperSDKObjectiveC_GetDictionaryItem","CasperSDKObjectiveC_GetEraInfo","CasperSDKObjectiveC_GetItem","CasperSDKObjectiveC_GetPeerList","CasperSDKObjectiveC_GetStatus","CasperSDKObjectiveC_PutDeploy","CasperSDKObjectiveC_Serialization"],
            path: "Tests",
            exclude: ["Ed25519CryptoTest.m","GetAuctionInfoTest.m","GetBalanceTest.m"]
        ),
        .target(
            name: "CasperSDKObjectiveC_CLValue",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/CLValue",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_Crypto",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperCryptoHandlePackage"],
            path: "Sources/CasperSDKObjectiveC/Crypto",
            //sources: ["Entity/CommonClasses"],
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetAuctionInfo",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetAuctionInfo",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetBalance",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetBalance",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetBlock",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetBlock",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetBlockTransfers",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetBlockTransfers",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetDeploy",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_Serialization","CasperCryptoHandlePackage"],
            path: "Sources/CasperSDKObjectiveC/GetDeploy",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetDictionaryItem",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetEraInfo"],
            path: "Sources/CasperSDKObjectiveC/GetDictionaryItem",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetEraInfo",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetDeploy"],
            path: "Sources/CasperSDKObjectiveC/GetEraInfo",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetItem",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetEraInfo"],
            path: "Sources/CasperSDKObjectiveC/GetItem",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetPeerList",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetPeerList",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetStateRootHash",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/GetStateRootHash",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_GetStatus",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetPeerList"],
            path: "Sources/CasperSDKObjectiveC/GetStatus",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_PutDeploy",
            dependencies: ["CasperSDKObjectiveC_CommonClasses","CasperSDKObjectiveC_GetDeploy","CasperSDKObjectiveC_Crypto"],
            path: "Sources/CasperSDKObjectiveC/PutDeploy",
            publicHeadersPath: "Public"
                ),
        .target(
            name: "CasperSDKObjectiveC_Serialization",
            dependencies: ["CasperSDKObjectiveC_CommonClasses"],
            path: "Sources/CasperSDKObjectiveC/Serialization",
            publicHeadersPath: "Public"
                )
    ]
)
