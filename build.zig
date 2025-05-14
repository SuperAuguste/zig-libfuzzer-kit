const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const fuzzer = b.addLibrary(.{
        .name = "fuzzer",
        .linkage = .dynamic,
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
            .root_source_file = b.path("sanitizer_common.zig"),
        }),
    });

    fuzzer.root_module.addIncludePath(b.path("src"));
    fuzzer.root_module.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "FuzzerCrossOver.cpp",
            "FuzzerDataFlowTrace.cpp",
            "FuzzerDriver.cpp",
            "FuzzerExtFunctionsDlsym.cpp",
            "FuzzerExtFunctionsWeak.cpp",
            "FuzzerExtFunctionsWindows.cpp",
            "FuzzerExtraCounters.cpp",
            "FuzzerExtraCountersDarwin.cpp",
            "FuzzerExtraCountersWindows.cpp",
            "FuzzerFork.cpp",
            "FuzzerInterceptors.cpp",
            "FuzzerIO.cpp",
            "FuzzerIOPosix.cpp",
            "FuzzerIOWindows.cpp",
            "FuzzerLoop.cpp",
            // "FuzzerMain.cpp",
            "FuzzerMerge.cpp",
            "FuzzerMutate.cpp",
            "FuzzerSHA1.cpp",
            "FuzzerTracePC.cpp",
            "FuzzerUtil.cpp",
            "FuzzerUtilDarwin.cpp",
            "FuzzerUtilFuchsia.cpp",
            "FuzzerUtilLinux.cpp",
            "FuzzerUtilPosix.cpp",
            "FuzzerUtilWindows.cpp",
        },
        .language = .cpp,
    });
    b.installArtifact(fuzzer);

    const example = b.addExecutable(.{
        .name = "example",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,
        }),
    });

    example.addCSourceFile(.{
        .file = b.path("example.c"),
        .flags = &.{"-fsanitize=fuzzer-no-link"},
    });
    example.linkLibrary(fuzzer);
    example.addCSourceFile(.{
        .file = b.path("src/FuzzerMain.cpp"),
        .language = .cpp,
    });

    const run_example = b.addRunArtifact(example);
    if (b.args) |args| run_example.addArgs(args);
    const example_step = b.step("example", "C fuzzing example");
    example_step.dependOn(&run_example.step);
}
