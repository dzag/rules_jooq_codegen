"""
"""
load("//rules_jooq_codegen:jooq_codegen.bzl", "jooq_srcs")

jooq_srcs(
  name = "nextone_classes",
  codegen_xml = "codegen.xml",
  url = "{DB_URL}",
  user = "{DB_USER}",
  password = "{DB_PASSWORD}",
  jooq_dep = "@jooq_codegen_maven//:org_jooq_jooq",
  jooq_meta_dep = "@jooq_codegen_maven//:org_jooq_jooq_meta",
  visibility = ["//visibility:public"],
)
