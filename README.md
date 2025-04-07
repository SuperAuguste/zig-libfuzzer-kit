# zig-libfuzzer-kit

Logical counterpart to https://github.com/kristoff-it/zig-afl-kit.

LLVM commit 091741a880c2df9d3d161068a12655d289633eee with an added `if (ExtraCountersBegin()) {`
in `FuzzerTracePC.h` to prevent illegal behavior.

See `build.zig` for usage. Run `zig build example` and watch `libFuzzer` figure out the magic string!

It may be interesting to integrate more things from `compiler-rt` (namely `asan`) in the future.
