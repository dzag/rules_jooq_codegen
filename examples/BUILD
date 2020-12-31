load("@rules_java//java:defs.bzl", "java_binary")

java_binary(
    name = "examples",
    srcs = glob(["src/main/java/**/*.java"]),
    main_class = "com.trerry.examples.App",
    deps = [
        "//examples/db:nextone_classes",
        "@jooq_codegen_maven//:mysql_mysql_connector_java",
        "@jooq_codegen_maven//:org_jooq_jooq",
        "@jooq_codegen_maven//:org_jooq_jooq_meta",
    ],
)
