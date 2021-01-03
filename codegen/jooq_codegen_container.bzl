"""
Docs
"""

load("@rules_java//java:defs.bzl", "java_binary", "java_library")

def _get_var(_cxt, attr_name):
    attr_value = getattr(_cxt.attr, attr_name)

    is_start_bracket = attr_value[:1] == "{"
    is_end_bracket = attr_name[-1:] == "}"

    if is_start_bracket and is_end_bracket:  # It's a replace-able value
        real_value = attr_value[1:-1]
        result = _cxt.var.get(real_value)  # _ctx.var is a map has been passed with --define params
        return result if result != None else attr_value

    return attr_value

def _jooq_gen_srcjar_impl(ctx):
    file = ctx.actions.declare_file(ctx.attr.name + ".srcjar")

    args = ctx.actions.args()
    args.add(file.path)
    args.add_all(ctx.attr.codegen_xml.files)

    args.add(ctx.attr.mysql_docker)
    args.add(ctx.attr.database_name)
    args.add(ctx.attr.changelog_master_path)

    ctx.actions.run(
        inputs = ctx.attr.codegen_xml.files.to_list(),
        outputs = [file],
        executable = ctx.executable.tool,
        arguments = [args],
        use_default_shell_env = True,
    )

    return [DefaultInfo(files = depset([file]))]

jooq_gen_srcjar = rule(
    implementation = _jooq_gen_srcjar_impl,
    attrs = {
        "codegen_xml": attr.label(allow_single_file = True),
        "tool": attr.label(
            executable = True,
            cfg = "host",
        ),
        "mysql_docker": attr.string(),
        "database_name": attr.string(),
        "changelog_master_path": attr.string(),
    },
    fragments = ["jvm"],
    host_fragments = ["jvm"],
)

def jooq_srcs2(
        codegen_xml,
        resources,
        mysql_docker,
        database_name,
        changelog_master_path,
        jooq_dep = "@maven//:org_jooq_jooq",
        jooq_meta_dep = "@maven//:org_jooq_jooq_meta",
        **kwargs):
    name = kwargs["name"]
    visibility = kwargs["visibility"]

    java_binary(
        name = name + "_codegen",
        main_class = "com.trerry.jooqcodegen.JooqCodegen2",
        visibility = ["//visibility:public"],
        resources = resources,
        runtime_deps = [
            "@rules_jooq_codegen//codegen:codegen",
        ],
    )

    jooq_gen_srcjar(
        name = name + "_srcjar",
        tool = name + "_codegen",
        codegen_xml = codegen_xml,
        mysql_docker = mysql_docker,
        database_name = database_name,
        changelog_master_path = changelog_master_path,
    )

    java_library(
        name = name,
        srcs = [":" + name + "_srcjar"],
        visibility = visibility,
        deps = [
            jooq_dep,
            jooq_meta_dep,
        ],
    )
