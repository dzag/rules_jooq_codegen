"""
Docs
"""

load("@rules_java//java:defs.bzl", "java_binary", "java_library")

def _get_var(_cxt, attr_name):
    attr_value = getattr(_cxt.attr, attr_name)

    is_start_bracket = attr_value[:1] == "{"
    is_end_bracket = attr_name[-1:] == "}"

    if is_start_bracket and is_end_bracket: # It's a replace-able value
        real_value = attr_value[1:-1]
        result = _cxt.var.get(real_value) # _ctx.var is a map has been passed with --define params
        return result if result != None else attr_value

    return attr_value

def _impl(ctx):
    file = ctx.actions.declare_file(ctx.attr.name + ".srcjar")

    args = ctx.actions.args()
    args.add(file.path)
    args.add_all(ctx.attr.codegen_xml.files)

    args.add(_get_var(ctx, "url"))
    args.add(_get_var(ctx, "user"))
    args.add(_get_var(ctx, "password"))

    ctx.actions.run(
        inputs = ctx.attr.codegen_xml.files.to_list(),
        outputs = [file],
        executable = ctx.executable.tool,
        arguments = [args],
        use_default_shell_env = True,
    )

    return [DefaultInfo(files = depset([file]))]

jooq_gensrcs = rule(
    implementation = _impl,
    attrs = {
        "codegen_xml": attr.label(allow_single_file = True),
        "url": attr.string(),
        "user": attr.string(),
        "password": attr.string(),
        "tool": attr.label(
            executable = True,
            cfg = "host",
        ),
    },
    fragments = ["jvm"],
    host_fragments = ["jvm"],
)

def jooq_srcs(
        name,
        visibility,
        codegen_xml,
        url,
        user,
        password,
        jooq_dep = "@maven//:org_jooq_jooq",
        jooq_meta_dep = "@maven//:org_jooq_jooq_meta",
        **kwargs):
    java_binary(
        name = name + "_codegen",
        main_class = "com.trerry.jooqcodegen.JooqCodegen",
        visibility = ["//visibility:public"],
        runtime_deps = [
            "@rules_jooq_codegen//rules_jooq_codegen:codegen",
        ],
    )

    jooq_gensrcs(
        name = name + "_srcjar",
        tool = name + "_codegen",
        codegen_xml = codegen_xml,
        url = url,
        user = user,
        password = password,
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
