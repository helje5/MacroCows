// swift-tools-version: 5.9
import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "MacroCows",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(
            name: "MacroCows",
            targets: ["MacroCows"]
        ),
        .executable(
            name: "MacroCowsClient",
            targets: ["MacroCowsClient"]
        ),
    ],
    dependencies: [
        // Depend on the latest Swift 5.9 prerelease of SwiftSyntax
        .package(url: "https://github.com/apple/swift-syntax.git",
                 from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b"),
        .package(url: "https://github.com/AlwaysRightInstitute/cows.git",
                 from: "1.0.10")
    ],
    targets: [
        .macro(
            name: "MacroCowsMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros",   package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "cows",                package: "cows")
            ]
        ),

        .target(name: "MacroCows", dependencies: ["MacroCowsMacros"]),

        // A client of the library, which is able to use the macro in its own code.
        .executableTarget(name: "MacroCowsClient", dependencies: ["MacroCows"]),

        // A test target used to develop the macro implementation.
        .testTarget(
            name: "MacroCowsTests",
            dependencies: [
                "MacroCowsMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
            ]
        ),
    ]
)
