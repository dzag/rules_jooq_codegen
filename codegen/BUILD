"""
"""

load("@rules_java//java:defs.bzl", "java_library")

package(default_visibility = ["//visibility:public"])

java_library(
    name = "codegen",
    srcs = glob(["src/main/java/**/*.java"]),
    visibility = ["//visibility:public"],
    runtime_deps = [
    ],
    deps = [
        "@maven//:mysql_mysql_connector_java",
        "@maven//:org_jooq_jooq",
        "@maven//:org_jooq_jooq_codegen",
        "@maven//:org_jooq_jooq_meta",
        "@maven//:org_liquibase_liquibase_core",
        "@maven//:org_testcontainers_jdbc",
        "@maven//:org_testcontainers_mysql",
        "@maven//:org_testcontainers_testcontainers",
    ],
)
