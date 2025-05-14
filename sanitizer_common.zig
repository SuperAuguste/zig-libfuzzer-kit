export fn __sanitizer_set_death_callback(
    callback: *const fn () callconv(.c) void,
) callconv(.c) void {
    _ = callback;
}

var in_crash_state: bool = false;
export fn __sanitizer_acquire_crash_state() callconv(.c) bool {
    return !@atomicRmw(bool, &in_crash_state, .Xchg, true, .acq_rel);
}

export fn __sanitizer_print_stack_trace() callconv(.c) void {
    @panic("");
}
