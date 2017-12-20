// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "VaporBlog",
    products: [
        .library(name: "App", targets: ["App"]),
        .executable(name: "Run", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0")),
        .package(url: "https://github.com/vapor/leaf-provider.git", .upToNextMajor(from: "1.1.0")),
	.package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.0.0")),
	.package(url: "https://github.com/vapor/mysql-provider.git", .upToNextMajor(from: "2.0.0")),
	.package(url: "https://github.com/vapor/auth-provider.git", .upToNextMajor(from: "1.0.0")),
	.package(url: "https://github.com/nodes-vapor/slugify", .upToNextMajor(from: "1.0.0")),
	.package(url: "https://github.com/vapor-community/markdown-provider.git", .upToNextMajor(from: "1.1.0")),
	.package(url: "https://github.com/nodes-vapor/paginator.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
		name: "App",
		dependencies: [
			"Vapor",
			"LeafProvider",
			"FluentProvider",
			"MySQLProvider",
			"AuthProvider",
			"MarkdownProvider",
			"Slugify",
			"Paginator"
		],
		exclude: [
			"Config",
			"Database",
			"Public",
			"Resources"
		]
	),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App", "Testing"])
    ]
)


