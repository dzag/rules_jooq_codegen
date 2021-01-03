workspace(name = "rules_jooq_codegen")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JVM_EXTERNAL_TAG = "3.3"

RULES_JVM_EXTERNAL_SHA = "d85951a92c0908c80bd8551002d66cb23c3434409c814179c0ff026b53544dab"

http_archive(
    name = "rules_jvm_external",
    sha256 = RULES_JVM_EXTERNAL_SHA,
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", jooq_codegen_maven_install = "maven_install")

JOOQ_VERSION = "3.14.4"

jooq_codegen_maven_install(
    name = "jooq_codegen_maven",
    artifacts = [
        "org.jooq:jooq:%s" % JOOQ_VERSION,
        "org.jooq:jooq-meta:%s" % JOOQ_VERSION,
        "org.jooq:jooq-codegen:%s" % JOOQ_VERSION,
        "mysql:mysql-connector-java:8.0.22",
        "org.testcontainers:testcontainers:1.15.1",
        "org.testcontainers:mysql:1.15.1",
        "org.liquibase:liquibase-core:4.2.2",
    ],
    fetch_sources = True,
    repositories = [
        "https://repo1.maven.org/maven2",
    ],
)
