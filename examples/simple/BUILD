load("@rules_java//java:defs.bzl", "java_binary")

java_binary(
    name = "simple",
    srcs = glob(["src/main/java/**/*.java"]),
    main_class = "com.trerry.examples.App",
    deps = [
        "//db:nextone_classes",
        "@maven//:mysql_mysql_connector_java",
        "@maven//:org_jooq_jooq",
        "@maven//:org_jooq_jooq_meta",
    ],
)
