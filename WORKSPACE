workspace(name = "rules_jooq_codegen")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "remote_java_tools_linux",
    sha256 = "085c0ba53ba764e81d4c195524f3c596085cbf9cdc01dd8e6d2ae677e726af35",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v10.6/java_tools_javac11_linux-v10.6.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11_v10.6/java_tools_javac11_linux-v10.6.zip",
    ],
)

http_archive(
    name = "remote_java_tools_windows",
    sha256 = "873f1e53d1fa9c8e46b717673816cd822bb7acc474a194a18ff849fd8fa6ff00",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v10.6/java_tools_javac11_windows-v10.6.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11_v10.6/java_tools_javac11_windows-v10.6.zip",
    ],
)

http_archive(
    name = "remote_java_tools_darwin",
    sha256 = "d15b05d2061382748f779dc566537ea567a46bcba6fa34b56d7cb6e6d668adab",
    urls = [
        "https://mirror.bazel.build/bazel_java_tools/releases/javac11/v10.6/java_tools_javac11_darwin-v10.6.zip",
        "https://github.com/bazelbuild/java_tools/releases/download/javac11_v10.6/java_tools_javac11_darwin-v10.6.zip",
    ],
)
