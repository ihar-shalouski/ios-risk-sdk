// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "RiskSDK",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "RiskSDK", targets: ["RiskSDK"])
    ],
    targets: [
        .target(
            name: "RiskSDK",
            path: "RiskSDK"
        ),
        .testTarget(
            name: "RiskSDKTests",
            dependencies: ["RiskSDK"],
            path: "RiskSDKTests",
            resources: [.process("Resources")]
        )
    ]
)
