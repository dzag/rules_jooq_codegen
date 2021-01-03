"""
"""

load("@rules_jooq_codegen//codegen:defs.bzl", "jooq_srcs", "jooq_srcs2")

jooq_srcs(
    name = "nextone_classes_old",
    codegen_xml = "codegen.xml",
    jooq_dep = "@maven//:org_jooq_jooq",
    jooq_meta_dep = "@maven//:org_jooq_jooq_meta",
    password = "{DB_PASSWORD}",
    url = "{DB_URL}",
    user = "{DB_USER}",
    visibility = ["//visibility:public"],
)

jooq_srcs2(
    name = "nextone_classes",
    changelog_master_path = "/migration/db.changelog-master.xml",
    codegen_xml = "codegen.xml",
    database_name = "trerry",
    mysql_docker = "mysql:8.0.22",
    resources = [
        "//:changelog",
        "//:master",
    ],
    visibility = ["//visibility:public"],
)
