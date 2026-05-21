// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "Rlottie",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Crlottie", targets: ["Crlottie"]),
    ],
    targets: [
        .target(
            name: "Crlottie",
            path: ".",
            exclude: [
                "example",
                "test",
                "src/wasm",
                // ARM hand-written assembly that requires linking the rest of pixman.
                // We force the portable C path via -U__ARM_NEON__ in cxxSettings instead.
                "src/vector/pixman/pixman-arm-neon-asm.S",
            ],
            publicHeadersPath: "inc",
            cxxSettings: [
                .headerSearchPath("src/vector"),
                .headerSearchPath("src/vector/freetype"),
                .headerSearchPath("src/vector/pixman"),
                .headerSearchPath("src/vector/stb"),
                .headerSearchPath("src/lottie"),
                .headerSearchPath("src/lottie/rapidjson"),
                .headerSearchPath("src/lottie/zip"),
                .headerSearchPath("src/binding/c"),
                .define("RLOTTIE_BUILD", to: "1"),
                // stb_image is also vendored by other deps in some consumers — mark our copy
                // static-local to avoid duplicate-symbol link errors.
                .define("STB_IMAGE_STATIC", to: "1"),
                .unsafeFlags([
                    "-fno-exceptions",
                    "-fno-rtti",
                    "-fvisibility=hidden",
                    "-Wno-unused-parameter",
                    "-U__ARM_NEON__",
                    "-U__ARM_NEON",
                ]),
            ]
        ),
    ],
    cxxLanguageStandard: .cxx14
)
