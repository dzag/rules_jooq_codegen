"""
"""

load("@rules_jooq_codegen//codegen:defs.bzl", "jooq_srcs")

jooq_srcs(
    name = "nextone_classes",
    codegen_xml = "codegen.xml",
    jooq_dep = "@maven//:org_jooq_jooq",
    jooq_meta_dep = "@maven//:org_jooq_jooq_meta",
    password = "{DB_PASSWORD}",
    url = "{DB_URL}",
    user = "{DB_USER}",
    visibility = ["//visibility:public"],
)
