"""
"""

load("@rules_java//java:defs.bzl", "java_library")

exports_files([
    "jooq_codegen.bzl",
])

package(default_visibility = ["//visibility:public"])

java_library(
    name = "codegen",
    srcs = glob(["src/**/*.java"]),
    visibility = ["//visibility:public"],
    runtime_deps = [
    ],
    deps = [
        "@jooq_codegen_maven//:org_jooq_jooq",
        "@jooq_codegen_maven//:org_jooq_jooq_codegen",
        "@jooq_codegen_maven//:org_jooq_jooq_meta",
        "@jooq_codegen_maven//:mysql_mysql_connector_java",
    ],
)
